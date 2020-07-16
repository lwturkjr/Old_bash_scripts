#!/bin/sh

# Expanded captive portal auth for my old college's captive portal by a friend allowing users to run it and put in username/password without opening a browser

usage() {
    echo "";
    echo "EMCC Authentication version 1.0-bah";
    echo "Brian H's variant, derived from Lloyd Turk's athoauth1.sh and George Moody's authentication script. Modified for usability with security enhancements.";
    echo "";
    echo "usage: .emccauth <user>";
}
auth() {
    # Get password:
    read -s -p "Password: " password;
    curl -sd 'auth_user=${1}&auth_pass=${password}&accept=login' http://10.43.0.1:8000/?redirurl=http://www.google.com/;
}
if [ ! "${1}" ]
then
    usage
else
    auth
fi
