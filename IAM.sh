#!/bin/bash

create_users() {
 
  declare -A users
    users["Dev1"]="D@ni55cssmile22"
    users["Dev2"]="Mirages@d137"

   

    for name in "${!users[@]}"; do
        password="${users[$name]}"


        echo "Creating user: $name"
        aws iam create-user --user-name "$name"

        echo "Creating console password for $name"
        aws iam create-login-profile \
            --user-name "$name" \
            --password "$password" \
            --password-reset-required

        echo "User $name created with temporary password."
        echo
    done
}

create_group() {
    group_name="DevTeam"
    policy_arn="arn:aws:iam::aws:policy/AdministratorAccess"

    echo "Creating group: $group_name"
    aws iam create-group --group-name "$group_name"

    echo "Attaching policy $policy_arn to group $group_name"
    aws iam attach-group-policy \
        --group-name "$group_name" \
        --policy-arn "$policy_arn"

    echo "Adding users to group $group_name"
    for user in Dev1 Dev2; do
        aws iam add-user-to-group \
            --user-name "$user" \
            --group-name "$group_name"
    done
}

# Execute in order
create_users
create_group

