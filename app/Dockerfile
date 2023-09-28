FROM public.ecr.aws/amazonlinux/amazonlinux:2023

# Configure Linux for Neuron repository updates
RUN cat /etc/yum.repos.d/neuron.repo
RUN echo "[neuron]" >> /etc/yum.repos.d/neuron.repo
RUN echo "name=Neuron YUM Repository" >> /etc/yum.repos.d/neuron.repo
RUN echo "baseurl=https://yum.repos.neuron.amazonaws.com" >> /etc/yum.repos.d/neuron.repo
RUN echo "enabled=1" >> /etc/yum.repos.d/neuron.repo
RUN echo "metadata_expire=0" >> /etc/yum.repos.d/neuron.repo
RUN cat /etc/yum.repos.d/neuron.repo
RUN rpm --import https://yum.repos.neuron.amazonaws.com/GPG-PUB-KEY-AMAZON-AWS-NEURON.PUB

# Update OS packages 
RUN yum update -y

# Install OS headers 
RUN yum install kernel-devel-$(uname -r) kernel-headers-$(uname -r) -y

# Install git 
RUN yum install git -y

# install Neuron Driver
RUN yum install aws-neuronx-dkms-2.* -y

# Install Neuron Tools 
RUN yum install aws-neuronx-tools-2.* -y

# Add PATH
RUN export PATH=/opt/aws/neuron/bin:$PATH

# Install Python venv 
RUN yum install -y python3.7-venv gcc-c++ 

# Create Python venv
RUN python3.7 -m venv aws_neuron_venv_pytorch_inf1 

# Activate Python venv 
RUN source aws_neuron_venv_pytorch_inf1/bin/activate 
RUN python -m pip install -U pip 

# Install Jupyter notebook kernel
RUN pip install ipykernel 
RUN python3.7 -m ipykernel install --user --name aws_neuron_venv_pytorch_inf1 --display-name "Python (torch-neuron)"
RUN pip install jupyter notebook
RUN pip install environment_kernels

# Set pip repository pointing to the Neuron repository 
RUN python -m pip config set global.extra-index-url https://pip.repos.neuron.amazonaws.com

# Install PyTorch Neuron
RUN python -m pip install torch-neuron neuron-cc[tensorflow] "protobuf" torchvision
