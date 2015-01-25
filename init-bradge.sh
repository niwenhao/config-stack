#!/bin/bash -x

function init_br() {
	local brname=$1
	local braddr=$2

	brctl show | grep $brname >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		brctl addbr $brname
		ifconfig $brname $braddr netmask 255.255.255.0
	fi
}

init_br brmgr 10.0.0.1
init_br brtun 10.0.1.1
init_br brstg 10.0.2.1
init_br brext 10.0.3.1
init_br brbusiness 10.0.4.1

iptables -t nat -A POSTROUTING -s 10.0.0.0/16 -j MASQUERADE
