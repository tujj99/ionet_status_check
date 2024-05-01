#!/bin/bash

# 设置环境变量，根据自己的cuda和nvidia-smi位置设置
export PATH="$PATH:/usr/local/cuda-12.2/bin:/usr/lib/wsl/lib"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda-12.2/lib64/"

# 设置变量
device_id=""  # 替换成你的
user_id=""      # 替换成你的
device_name=""  # 替换成你的
system="linux"              # linux 或 mac
gpu=true                   # false 或 true
log_file="/home/tim/ionet_status.log"  # 日志文件路径,替换成你的 
bin_path="/home/tim"                   # 脚本执行路径，替换成你的

# 获取当前时间
current_time=$(date "+%Y-%m-%d %H:%M:%S")

# 添加日志函数
log() {
    echo "$1" >> "$log_file"
}

# 记录程序状态
record_status() {
    docker_ps_output=$(docker ps)
    if [[ $(echo "$docker_ps_output" | grep -c "io-worker-monitor") -eq 1 && $(echo "$docker_ps_output" | grep -c "io-worker-vc") -eq 1 ]]; then
        log "$current_time - NODE IS WORKING"
        # 如果你希望记录更多信息，例如容器的 ID 或名称，你可以使用下面的命令：
        # log "$current_time - NODE IS WORKING. Container IDs: $(echo "$docker_ps_output" | grep "io-worker-monitor\|io-worker-vc" | awk '{print $1}')"
    else
        log "$current_time - NODE STOPPED"
    fi
}

# 判断操作系统
if [[ "$system" == "linux" ]]; then
    os="linux"
    os2="Linux"
elif [[ "$system" == "mac" ]]; then
    os="macOS"
fi

# 检查容器状态并重启
if [[ $(docker ps | grep -c "io-worker-monitor") -eq 1 && $(docker ps | grep -c "io-worker-vc") -eq 1 ]]; then
    log "$current_time - node is working"
else
    log "$current_time - node stopped and re-build containers..."
    docker rm -f $(docker ps -aq) && docker rmi -f $(docker images -q) 
    yes | docker system prune -a
    binary_name=io_net_launch_binary_$system

    rm -rf $binary_name && rm -rf ionet_device_cache.txt
    curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/io_net_launch_binary_$system -o $binary_name
    chmod +x $binary_name
    #log "Running command: $bin_path/$binary_name --device_id=$device_id --user_id=$user_id --operating_system=\"$os2\" --usegpus=$gpu --device_name=$device_name"
    #log "Current PATH: $PATH"
    #log "Current LD_LIBRARY_PATH: $LD_LIBRARY_PATH"

    yes | $bin_path/$binary_name --device_id=$device_id --user_id=$user_id --operating_system="$os2" --usegpus=$gpu --device_name=$device_name >> "run.log" 2>&1

fi
