# ionet_status_check

脚本作用：定时检测io.net docker状态，如遇到状态异常则重新load新images

# 设置方法：

# 下载脚本：
wget https://github.com/tujj99/ionet_status_check/blob/main/ionet_check.sh

# 给与运行权限：
chmod +x ionet_check.sh

加入定时任务：
crontab -e
*/5 * * * * * ionet_check.sh

查看脚本日志：
cat ionet_status.log

查看命令执行日志:
cat run.log
