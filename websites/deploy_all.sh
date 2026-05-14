#!/bin/bash
# Appelé en local

# Version rapide, idéalement il faudrait avoir un playbook ansible qui déploit tout en même temps (pour éviter N executions playbooks comme actuellement)

source ./websites/.env

set -euo pipefail

deploy_website() {
    WEBSITE="$1"
    export WEBSITE_DOMAIN="$WEBSITE"

    if [[ -f "websites/deploy/$WEBSITE/package.json" ]]
    then
        TYPE="vite"
    else
        TYPE="html"
    fi

    echo Déploiement du site "$WEBSITE_DOMAIN de type $TYPE"

    if [[ $TYPE == html ]]
    then 
        ansible-playbook --private-key ~/.ssh/github_deploy_key -u $FRONT_USER -i "$FRONT_HOST," ansible/playbooks/deploy-html-website.yml 
    fi

    if [[ $TYPE == vite ]]
    then 
        ansible-playbook --private-key ~/.ssh/github_deploy_key -u $FRONT_USER -i "$FRONT_HOST," ansible/playbooks/deploy-vite-website.yml 
    fi 
}

# portail en premier
deploy_website "portal.blavogiez.fr"

WEBSITES=$(ls websites/deploy | grep -v portal.blavogiez.fr)

for WEBSITE in $WEBSITES
do
    deploy_website "$WEBSITE"
done
