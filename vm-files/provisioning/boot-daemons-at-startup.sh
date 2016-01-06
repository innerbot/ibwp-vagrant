#!/bin/bash

sysv-rc-conf --level 2345 nginx on
sysv-rc-conf --level 016 nginx off
update-rc.d nginx enable

sysv-rc-conf --level 2345 php5-fpm on
sysv-rc-conf --level 016 php5-fpm off
update-rc.d php5-fpm enable

sysv-rc-conf --level 2345 mysql on
sysv-rc-conf --level 016 mysql off
update-rc.d mysql enable