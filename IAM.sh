#!/bin/bash

create_users () {

declare -A user

user[name]="Dev1"
user[password]="D@ni55cssmile22"
echo "User for people: ${user[name]}"
echo "User for password: ${user[password]}"
echo "Keys for array: ${!user[@]}"

aws iam create-user --user-name "${user[name]}"

aws iam create-login --user "${user[name]}" --pasword "${user[password]}" --password-reset-required

echo login tempory created for "${user[name]}"
}

create_users () {

