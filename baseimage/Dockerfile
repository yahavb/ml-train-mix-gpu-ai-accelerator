FROM public.ecr.aws/docker/library/ubuntu:23.10

RUN ls -la /home/ubuntu

RUN apt update && apt-get install -y python3-venv g++ 
ADD requirements.txt /home/ubuntu/requirements.txt

# Python venv for neuron
RUN python3.10 -m venv aws_neuron_venv_pytorch && \
    source aws_neuron_venv_pytorch/bin/activate && \
    python -m pip install -U pip && \
    pip install ipykernel && \
    python3.10 -m ipykernel install --user --name aws_neuron_venv_pytorch --display-name "Python (torch-neuronx)" && \
    pip install jupyter notebook && \
    pip install environment_kernels && \
    python -m pip config set global.extra-index-url https://pip.repos.neuron.amazonaws.com && \
    python -m pip install wget && \ 
    python -m pip install awscli && \
    python -m pip install neuronx-cc==2.* torch-neuronx torchvision && \
    deactivate

# Python venv for CUDA
RUN python3.10 -m venv aws_cuda_venv_pytorch && \
    source aws_cuda_venv_pytorch/bin/activate && \
    python -m pip install -U pip && \
    python -m pip install wget && \
    python -m pip install awscli && \
    pip install -r /home/ubuntu/requirements.txt && \
    pip install --force-reinstall --no-deps protobuf==3.20.0 && \
    deactivate
