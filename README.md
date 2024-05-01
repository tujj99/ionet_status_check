# ionet_status_check

脚本作用：定时检测io.net docker状态，如遇到状态异常则重新load新images

设置方法：

# 下载脚本：
wget .

# 给与运行权限：
chmod +x .

加入定时任务：
crontab -e
*/5 * * * * * .

查看脚本日志：
cat .

查看命令执行日志:
cat .
