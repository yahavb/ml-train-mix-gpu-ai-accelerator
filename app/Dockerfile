FROM public.ecr.aws/docker/library/ubuntu:22.04

RUN apt update -y && apt-get install -y python3-dev python3.10-venv g++ 
COPY * /home/ubuntu/

RUN ls -l /home/ubuntu

# Python venv for CUDA
RUN python3.10 -m venv aws_cuda_venv_pytorch && \
    . aws_cuda_venv_pytorch/bin/activate && \
    python -m pip install -U pip && \
    python -m pip install wget && \
    python -m pip install awscli && \
    pip install -r /home/ubuntu/requirements.txt && \
    pip install --force-reinstall --no-deps protobuf==3.20.0 && \
    deactivate
