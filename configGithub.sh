#!/usr/bin/env bash

configGithub() {

    read -p "Config github? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
    #REF:https://help.github.com/en/github/authenticating-to-github/checking-for-existing-gpg-keys
    gpg --list-secret-keys --keyid-format LONG
    read -p 'ENTER your Github.com username: ' GITHUB_USER_NAME
    #read -sp 'Password: ' GITHUB_USER_PASSWORD
    git config --global user.name $GITHUB_USER_NAME
    echo Thankyou $GITHUB_USER_NAME
    read -p 'ENTER your Github.com user email: ' GITHUB_USER_EMAIL
    git config --global user.email $GITHUB_USER_EMAIL
    echo Thankyou $GITHUB_USER_NAME for your email.
    #read -p 'ENTER your public gpg signing key id: ' PUBLIC_GPG_SIGNING_KEY_ID
    #git config --global user.signingkey $PUBLIC_GPG_SIGNING_KEY_ID
    #echo Thankyou $GITHUB_USER_NAME for public gpg signing key id.
    fi;

    #REF: https://gist.github.com/grenade/6318301
    #REF: https://www.digitalocean.com/docs/droplets/resources/troubleshooting-ssh/authentication/#fixing-key-permissions-and-ownership

    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys
    chmod 644 ~/.ssh/known_hosts
    chmod 644 ~/.ssh/config

    echo Creating the ssh keys
    DATE=$(date +%s)
    ssh-keygen -t rsa -b 4096 -N '' -C $GITHUB_USER_EMAIL -f ~/.ssh/$DATE.github_rsa
echo
    eval "$(ssh-agent -s)"
echo
    ssh-add ~/.ssh/$DATE.github_rsa
echo
    sudo chmod 600 ~/.ssh/$DATE.github_rsa
echo
    sudo chmod 644 ~/.ssh/$DATE.github_rsa.pub
echo
    cat  ~/.ssh/$DATE.github_rsa.pub
echo
    echo add this to you github account...
echo

}
sudo
mkdir -p ~/.ssh
mkdir -p ~/.ssh/authorized_keys
mkdir -p ~/.ssh/known_hosts
mkdir -p ~/.ssh/config
configGithub





