#!/bin/sh
###################################################
# TR Murphy
# max_ring_buffer.sh
#
# run this as root
# maxes out RX and TX buffers on solarflare cards
###################################################

list=`ifconfig  | grep ens | awk -F ":" '{print $1}'`
#####################################
# set RX buffer to Max
#####################################
for ETH in $list
do
    tmp=`ethtool -g $ETH | grep RX: | head -1`
    RXS=`echo $tmp | awk -F ":" '{print $2}'`
    ethtool -G $ETH rx $RXS	
done

#####################################
# set TX buffer to Max
#####################################
for ETH in $list
do
    tmp=`ethtool -g $ETH | grep TX: | head -1`
    TXS=`echo $tmp | awk -F ":" '{print $2}'`
    ethtool -G $ETH tx $TXS
done

exit 0
