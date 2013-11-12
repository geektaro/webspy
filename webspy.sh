#!/bin/bash
source $(dirname $0)/webspy.cnf
LOGPATH="${BASEPATH}webspy.log"
DATETIME=`date +'%Y-%m-%d %H:%M'`
cnt=`curl -s $URL |grep -o $TERM |wc -l`
if [ ! -f $LOGPATH ]; then
	touch $LOGPATH
fi
prev_cnt=`tail -n1 $LOGPATH |cut -f2`
if [ -z $prev_cnt ]; then
	prev_cnt=$cnt
fi
if [ $cnt -ne $prev_cnt ]; then
	wget -q -O- "http://www.tui3.com/api/send?k=${APIKEY}&p=1&t=${TEL}&c=${MESG}"
fi
echo -e $DATETIME"\t"$cnt >> $LOGPATH
