#!/bin/bash
echo -e "\033[1;32mWelcome to IPGW Certification Assistant ^_^\033[0m"
declare -g cas="https://pass.neu.edu.cn/tpass/login?service=http://ipgw.neu.edu.cn/srun_portal_sso?"
declare -g username=""
declare -g password=""

readCredentials() {
  read -r -p "Enter your username: " username
  read -r -s -p "Enter your password: " password
  echo ""
}

checkLogin() {
    local message
    message=$(echo "$1" | grep -oP '"message":"\K[^"]+')
    if [[ "${message}" == "success" ]]; then
        echo -e "\033[32m[+]\033[0m Login success"
    else
        echo -e "\033[31m[+]\033[0m Login failure"
    fi
}

getInfo() {
    lt=$(echo "${res}" | grep -Po 'name="lt" value="\K[^"]+')
    tpass=$(echo "${res}" | grep -Po 'jsessionid_tpass=\K[^?]*')
    data="rsa=${username}${password}${lt}&ul=${#username}&pl=${#password}&lt=${lt}&execution=e1s1&_eventId=submit"
}

if command -v curl >/dev/null 2>&1; then
    echo -e "\033[32m[+]\033[0m curl detected"
    loginout() {
        local res
        res=$(curl -s "https://ipgw.neu.edu.cn/cgi-bin/srun_portal?action=logout")
        if [[ "$res" = *ok ]]; then
            echo -e "\033[32m[+]\033[0m Login out ok"
        else 
            echo -e "\033[31m[+]\033[0m Not online"
        fi
    }
    res=$(curl -s -H "Accept: application/json" "https://ipgw.neu.edu.cn/cgi-bin/rad_user_info")
    if [[ "$res" = *user_name* ]]; then
        echo -e "\033[31m[+]\033[0m You are already online"
        unset readCredentials checkLogin getInfo res 
        return 1
    fi
    readCredentials
    res=$(curl -s "${cas}")
    getInfo
    id=$(curl -s https://ipgw.neu.edu.cn/index_1.html |  grep -oP 'ac_id=\K[^&]+')
    ticket=$(curl -s -X POST -H "Content-Type: application/x-www-form-urlencoded" \
       -H "Cookie: jsessionid_tpass=${tpass}" \
       -H "Referer: ${cas}" \
       -d "${data}" \
       "${cas}" | grep -oP '<a [^>]*href="[^"]*ticket=\K[^"]+')
    res=$(curl -s "ipgw.neu.edu.cn/v1/srun_portal_sso?ac_id=${id}&ticket=${ticket}")
elif command -v wget >/dev/null 2>&1; then
    echo -e "\033[32m[+]\033[0m wget detected"
    loginout() {
        local res
        if [[ "$res" = *ok ]]; then
            echo -e "\033[32m[+]\033[0m Login out ok"
        else 
            echo -e "\033[31m[+]\033[0m Not online"
        fi
    }
    res=$(wget -qO- --header="Accept: application/json" "https://ipgw.neu.edu.cn/cgi-bin/rad_user_info")
    if [[ "$res" = *user_name* ]]; then
        echo -e "\033[31m[+]\033[0m You are already online"
        unset readCredentials checkLogin getInfo res
        return 1
    fi
    readCredentials
    res=$(wget -qO- "${cas}")
    getInfo
    id=$(wget -qO- https://ipgw.neu.edu.cn/index_1.html | grep -oP 'ac_id=\K[^&]+')
    ticket=$(wget --method POST --header "Content-Type: application/x-www-form-urlencoded" \
     --header "Cookie: jsessionid_tpass=${tpass}" \
     --header "Referer: ${cas}" \
     --body-data "${data}" \
     --max-redirect=0 \
     "${cas}" -O - 2>&1 | grep -oP -m1 'ticket=\K[^ ]+')
    res=$(wget -qO- "ipgw.neu.edu.cn/v1/srun_portal_sso?ac_id=${id}&ticket=${ticket}")
else
    echo -e "\033[31m[+]\033[0m No curl or wget installed"
fi
checkLogin "${res}"
unset readCredentials checkLogin getInfo cas username password res lt tpass data ticket id