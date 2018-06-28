#!/bin/bash

# Generating a new ssh key pair and adding public key on server version 2
# Authur: trangnth
# Date: 28/06/2018

echo "WELCOME TO SCRIPT"

check_distro()
{       
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
	for ip_server in `awk '{print $1}' list_of_servers.txt`; do
		echo "###########################################"
		echo "Generating key for server $ip_server..."
                username=$(grep -w "$ip_server" list_of_servers.txt | awk '{print $2}')
                password=$(grep -w "$ip_server" list_of_servers.txt | awk '{print $3}')	
		key_pri=~/.ssh/$ip_server.key
	        key_pub=$key_pri.pub

        	if [ -f $key_pri ]
	        then
        	        echo "Existed key for server $ip_server."
                	echo "Use ssh -o 'StrictHostKeyChecking no' -i $key_pri $username@$ip_server to login server."

        	else
	                sudo ssh-keygen -t rsa -N "" -f $key_pri -q 
        	        add_key
	        fi
	done
}

add_key()
{
        echo "Adding key on server..."
        install_sshpass

       	sudo sshpass -p "$password" ssh-copy-id  -o "StrictHostKeyChecking no" -i $key_pub -f $username@$ip_server

        if [ $? -eq 0 ]; then
       	        sudo rm $key_pub
                echo "Use ssh -o 'StrictHostKeyChecking no' -i $key_pri $username@$ip_server to login server."
               	echo "Done."
       	else
                sudo rm $key_pri*
               	echo "Don't copy key on server $ip_server"
       	fi
}

install_sshpass()
{
        sshpass -V &> /dev/null
        if [ $? -ne 0 ]
        then
                echo "Installing sshpass ..."
                sudo apt-get install sshpass &> /dev/nul
        fi
}

main()
{
        check_distro
        ssh_gen_key
}

main