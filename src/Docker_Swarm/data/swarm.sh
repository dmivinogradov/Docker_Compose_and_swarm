if [ "$(hostname)" = "manager01" ]; then
    sudo docker swarm init --advertise-addr "$(hostname -I | awk '{print $2}'):2377"
    JOIN_TOKEN=$(sudo docker swarm join-token worker -q)
    sudo sh -c " echo "$JOIN_TOKEN" "$(hostname -I | awk '{print $2}')"  >> ./swarm_info.txt"
    sudo docker network create --driver overlay hotel_network
    docker volume create portainer_data
    docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts
else
    TOKEN=$(scp \
    -i $VAGRANT_KEY \
    -o StrictHostKeyChecking=no \
    vagrant@$MANAGER_IP \
    "cat /home/vagrant/worker-token")

    scp vagrant@192.168.10.10:/home/vagrant/data/swarm_info.txt /home/vagrant/data/
    read JOIN_TOKEN MANAGER_IP < /home/vagrant/data/swarm_info.txt
    sudo docker swarm join --token $JOIN_TOKEN $MANAGER_IP:2377
fi