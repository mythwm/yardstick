#!/bin/bash

##############################################################################
# Copyright (c) 2015 Huawei Technologies Co.,Ltd and others.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

# check the status of a service

set -e

source /root/openrc

if [ $OS_INSECURE ] && [ "$(echo $OS_INSECURE | tr '[:upper:]' '[:lower:]')" = "true" ]; then
    SECURE="--insecure"
else
    SECURE=""
fi

ip=$(openstack ${SECURE} server list -f value | grep 'wm_watchdog1' | awk '{print $5}')
ssh -i /etc/yardstick/ssh/id_rsa -F /etc/yardstick/ssh/config root@$ip
sleep 6
echo "ccc" > /dev/watchdog
echo "feed dog success!"
echo c > /proc/sysrq-trigger


