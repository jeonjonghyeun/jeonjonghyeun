#!/bin/sh


### 해당 스크립트는 아래 환경으로 작성되었씁니다###
#언어셋 UTF-8
#목적 : CENTOS7 설치후 기본 설정 스크립트


#HOSTNAME 설정 

echo "Insert HOSTNAME plz:"
read HOST
echo $HOST
HOSTNAME=$HOST
if [ -n "$HOST" ]; then

hostnamectl set-hostname $HOST

else 

echo "HOSTNAME volume is Null"
fi

#SETLINUX 설정밒 방화벽 Disable

sed -i  s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config

systemctl disable firewalld
systemctl stop firewalld

#NETWORK 설정

DVICE=`nmcli conncetion show |grep 'ethernet' |awk '{print $NF}'|head -1 `

echo "Insert IP Adress"
 read IP
echo "Insert PREFIX"
 read PREFIX
echo "insert GATEWAY"
 read GATEWAY
echo "insert DNS"
 read DNS

echo "DVICE:$DVICE"
echo "IP:$IP"
echo "PREFIX:$PREFIX"
echo "GATEWAY:$GATEWAY"
echo "DNS:$DNS" 
echo -n "insert IP check [y/n]"
read $YN
if [ $YN -eq 'y' -o "$YN" -eq 'Y' ] ; then
 
echo "적용완료"
elif [ $YN -eq 'n' -o "$YN" -eq 'N' ] ;then

echo "다시적용"

fi








