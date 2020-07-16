#!/bin/bash
# curl command to autoauth with my old College's captive portal

curl -d 'auth_user=<username>&auth_pass=<password>&accept=login' http://10.43.0.1:8000/?redirurl=http://www.google.com/ 
