#!/usr/bin/env bash

WRKDIR=$(dirname $0)
CONFIG=$(dirname $0)
COOKIE_FILE=${WRKDIR}/galletita.txt
#POST_LOGIN_FILE=${CONFIG}/post_login.txt
#POST_ROUTER_RESTART=${CONFIG}/post_router_restart.txt
IP_ADDR="192.168.1.1"
#USER="$1"
#PASS="$2"

# Usage
usage () {
    echo "$0 "
    exit
}


# Login
login() {
    # Remove cookies, if any
    rm -f ${COOKIE_FILE}

    wget -S \
        -O /dev/null \
        --save-cookies ${COOKIE_FILE} \
        --keep-session-cookies \
        --post-data "username_login=${USER}&password_login=${PASS}&LanguageSelect=en&Language_Submit=0&login=Log+In" \
        http://${IP_ADDR}/goform/Docsis_system
}

# Restart
restart() {
    wget -S \
        -O /dev/null \
        --load-cookies ${COOKIE_FILE} \
        --save-cookies ${COOKIE_FILE} \
        --keep-session-cookies \
        --post-data "devicerestrat_Password_check=${PASS}&mtenRestore=Device+Restart&devicerestart=1&devicerestrat_getUsercheck=true" \
        http://${IP_ADDR}/goform/Devicerestart

}

# if [ $# -ne 2 ] ; then
#     echo "Usage: ${0} [user] [password]"
#     exit 1
# fi

echo "Cisco EPC3825"
read -p "User: " USER
read -s -p "Password: " PASS
login
restart
rm -f ${COOKIE_FILE}
