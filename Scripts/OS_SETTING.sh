#!/bin/sh

#Made in Jeon Jong Hyeun 
#Ver 1 Create Date 2021.07.04



#LOCAlE SETTING

function get_locale {
echo  """
_____________________________________________________________
!							    !
! 1. UTF-8						    !
!							    !
! 2. EUC_KR						    !
!				     			    !
!							    !
!___________________________________________________________!
"""
echo -n Select LOCALE :; read LOCALE
case $LOCALE in 
 1)
localectl set-locale LANG=ko_KR.utf8	
localectl status
;;

 2)
localectl set-locale LANG=ko_KR.euckr
localectl status
esac


}

# Bashrc & bash_profile Setting

function profile {

echo """ 
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
alias vi='vim'
export `cat /etc/locale.conf`

PS1=\"[\\h:\\w] \\\\$ \"
TMOUT=600

""" > /etc/skel/.bashrc

echo """
set nu              
set shiftwidth=4    
set showmatch       
set smartcase       
set ruler           
set cursorline      
set hlsearch        
set tabstop=4       
syntax on           
set background=dark 
colorscheme delek   

""" > /etc/skel/.vimrc

cp -a /etc/skel/.bashrc /root/
cp -a /etc/skel/.vimrc /root/

}

function PKG_Install {

yum -y install epel-release
yum -y install sysstat nmon telnet net-tools tcpping nc
yum -y  update  

}


function PROC_SETTING {
systemctl stop firewalld.service
systemctl disable firewalld.service
sed -i  s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config

}


function HOSTNAME_SETTING {
echo "HOSTNAMME Insert :"
read HOST
echo $HOST
HOSTNAME=$HOST
if [ -n "$HOST" ]; then

hostnamectl set-hostname $HOST

else

echo "HOSTNAME volume is Null"
fi

}
function IP_SETTING
{
#NETWORK 설정

DEVICE=`nmcli con show |grep 'ethernet' |awk '{print $NF}'|head -1 `
a=0
while [ $a -lt 1 ]
do
echo "Insert IP Adress"
 read IP
echo "Insert PREFIX"
 read PREFIX
echo "insert GATEWAY"
 read GATEWAY
echo "insert DNS"
 read DNS

echo "###########################"
echo "DVICE:$DEVICE   " 
echo "IP:$IP"
echo "PREFIX:$PREFIX"
echo "GATEWAY:$GATEWAY"
echo "DNS:$DNS" 
echo "###########################"
echo -n "insert IP check [y/n]"
read YN
if [ $YN == 'y' -o "$YN" == 'Y' ] ; then

nmcli con modify $DEVICE ipv4.method manual
nmcli con modify $DEVICE ipv4.addresses $IP/$PREFIX
nmcli con modify $DEVICE ipv4.gateway $GATEWAY
nmcli con modify $DEVICE ipv4.dns $DNS
nmcli con up $DEVICE

echo "적용완료"
a=1
elif [ $YN == "n" -o "$YN" == 'N' ] ;then

echo "Re Insert IP Infomation "

fi
done
}


get_locale
profile
PROC_SETTING
HOSTNAME_SETTING
IP_SETTING
PKG_Install
