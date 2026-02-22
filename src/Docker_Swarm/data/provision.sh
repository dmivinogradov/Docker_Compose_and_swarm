sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker vagrant


echo "'''Проверка установки docker,,,"
if command -v docker &> /dev/null; then
        echo "Docker instaling"
        docker --version
else
        echo "Docker not install"
        exit 1
fi

sudo chmod +x data/swarm.sh