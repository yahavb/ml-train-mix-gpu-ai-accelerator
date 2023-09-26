#!/bin/bash

cd /home/ubuntu

if [ -n "$AI_CHIP" ]; then
  echo "need to know where to set the instance ai chip, neuron or cuda in AI_CHIP so we know what SDK to install"
  echo "example export AI_CHIP=/home/ubuntu/.ai_chip"
  exit
fi

# Install neuron drivers and tools
# Configure Linux for Neuron repository updates
. /etc/os-release
tee /etc/apt/sources.list.d/neuron.list > /dev/null <<EOF
deb https://apt.repos.neuron.amazonaws.com ${VERSION_CODENAME} main
EOF
wget -qO - https://apt.repos.neuron.amazonaws.com/GPG-PUB-KEY-AMAZON-AWS-NEURON.PUB | sudo apt-key add -

# Update OS packages 
apt-get update -y

# Install OS headers 
apt-get install linux-headers-$(uname -r) -y

# Install git 
apt-get install git -y
# install Neuron Driver
apt-get install aws-neuronx-dkms=2.* -y
# Install Neuron Runtime 
apt-get install aws-neuronx-collectives=2.* -y
apt-get install aws-neuronx-runtime-lib=2.* -y

# Install Neuron Tools 
apt-get install aws-neuronx-tools=2.* -y
export PATH=/opt/aws/neuron/bin:$PATH

# Install Python venv 
apt-get install -y python3.10-venv g++ 

# Create Python venv
python3.10 -m venv aws_neuron_venv_pytorch 

# Activate Python venv 
. aws_neuron_venv_pytorch/bin/activate 
python -m pip install -U pip 

# "Install Jupyter notebook kernel"

pip install ipykernel 

python3.10 -m ipykernel install --name aws_neuron_venv_pytorch --display-name "Python (torch-neuronx)"
pip install jupyter notebook
pip install environment_kernels

# Set pip repository pointing to the Neuron repository 
python -m pip config set global.extra-index-url https://pip.repos.neuron.amazonaws.com

# Install wget, awscli 
python -m pip install wget 
python -m pip install awscli 

# Install Neuron Compiler and Framework
python -m pip install neuronx-cc==2.* torch-neuronx torchvision

echo "neuron" > $AI_CHIP
deactivate

./prep_dataset.sh
