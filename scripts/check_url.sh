#!/bin/sh

uma(){
	TMPFILE="/tmp/$$.txt"
	/usr/bin/curl -m 5 -sx 10.0.0.1:80 http://scrm.umaman.com/admin/index/phpinfo > $TMPFILE
	#M=$(/usr/bin/wc -l $TMPFILE | awk '{print $1}')
	M=$(/usr/bin/nl $TMPFILE |tail -n 1|awk '{print $1}')
	H=$(/bin/grep -n '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">' $TMPFILE |/usr/bin/tail -n 1|awk -F':' '{print $1}')
	B=$(/bin/grep -n '</div></body></html>$' $TMPFILE |/usr/bin/head -n 1|awk -F':' '{print $1}')
	rm $TMPFILE -f
	#echo "M:$M H:$H B:$B";exit
	if [ $H -eq 1  -a $B -eq $M ];then
		echo 1
	else
		echo 0
	fi
}

iwebsite2() {
	# 监测 http://iwebsite2.umaman.com/
	if /usr/bin/curl -m 5 -sx 10.0.0.1:80 http://iwebsite2.umaman.com/ | grep -i -e '^Welcome to visit our website!$' -q ;then
		echo 1
	else
		echo 0
	fi
}

rosefinch() {
	# 监测 http://www.rosefinch.cn/
	if /usr/bin/curl -m 5 -sx 115.29.178.105:80 http://www.rosefinch.cn/ | grep -e '朱雀投资' -q ;then
		echo 1
	else
		echo 0
	fi
}

grep -q -P -e "^${1}[ |\t]?\(\)[ |\t]?\{" $0 && $1
