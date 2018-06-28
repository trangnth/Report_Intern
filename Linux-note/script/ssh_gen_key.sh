#!/bin/bash

# Generating a new ssh key pair and adding public key on server 
# Authur: trangnth
# Date: 27/06/2018


echo "Welcome to script"

check_distro()
{
        echo $date
        os=$(lsb_release -is)
        release=$(lsb_release -rs)
        if [ $os != 'Ubuntu' ] && [ $release != '16.04' ]
        then
                echo "Script available to Ubuntu 16.04!"
                echo "ERROR: This OS is not compatible" >> /var/log/ssh_gen_key.log
        exit 1
        fi
}

ssh_gen_key(){
        echo "Enter IP server: "
        read ip_server
        key_pri=$ip_server.key
        key_pub=$key_pri.pub
        if [ -f /root/.ssh/$key_pri ]
        then
                echo "Existed key for server."
                echo "Use ssh -i /root/.ssh/$key_pri username@$ip_server to login server."
                exit 0

        else
                echo "Enter username: "
                read username
                echo "Enter password for user $username: "
                read password
                echo "Generating key pair..."
                ssh-keygen -t rsa -N "" -f /root/.ssh/$key_pri -q
                add_key
        fi
}

add_key()
{
        echo "Adding key on server..."
#       sudo apt-get install sshpass
        sshpass -p "$password" ssh-copy-id  -o "StrictHostKeyChecking no" -i /root/.ssh/$key_pub -f $username@$ip_server
        #sshpass -p "1" ssh-copy-id  -o "StrictHostKeyChecking no" -i /root/.ssh/id_rsa.pub -f trang@192.168.60.135
        if [ $? -eq 0 ]; then
                rm /root/.ssh/$key_pub
                echo "Use ssh -i /root/.ssh/$key_pri $username@$ip_server to login server."
                echo "Finished."
        else
                rm /root/.ssh/$key_pri*
                echo "Don't copy key on server"
        fi
}

main()
{
        check_distro
        ssh_gen_key
}

main