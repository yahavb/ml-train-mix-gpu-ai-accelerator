FROM public.ecr.aws/docker/library/ubuntu:23.10

RUN apt-get update -y
RUN apt-get install -y wget gnupg2
RUN . /etc/os-release 
COPY neuron.list /etc/apt/sources.list.d/neuron.list
RUN wget -qO - https://apt.repos.neuron.amazonaws.com/GPG-PUB-KEY-AMAZON-AWS-NEURON.PUB | apt-key add -
RUN apt-get update -y
RUN apt-get install linux-headers-$(uname -r) -y
RUN apt-get install git -y
RUN apt-get install aws-neuronx-dkms=2.* -y
RUN apt-get install aws-neuronx-collectives=2.* -y
RUN apt-get install aws-neuronx-runtime-lib=2.* -y
RUN apt-get install aws-neuronx-tools=2.* -y
RUN export PATH=/opt/aws/neuron/bin:$PATH
