# ionet_status_check

脚本作用：定时检测io.net docker状态，如遇到状态异常则重新load新images
![image](https://github.com/tujj99/ionet_status_check/assets/53027340/70335781-3327-4afb-b2f8-b26422540e20)
![image](https://github.com/tujj99/ionet_status_check/assets/53027340/dc0ef1e6-ba2d-4fb3-b38f-09a29eaf0628)


# 设置方法：

# 下载脚本：
wget https://github.com/tujj99/ionet_status_check/blob/main/ionet_check.sh

# 给与运行权限：
chmod +x ionet_check.sh

# 加入定时任务：
crontab -e

*/5 * * * * * ionet_check.sh

# 查看脚本日志：
cat ionet_status.log

# 查看命令执行日志:
cat run.log
