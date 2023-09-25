#!/bin/bash

if [ -n "$AI_CHIP" ]; then
  echo "need to know where to set the instance ai chip, neuron or cuda in AI_CHIP so we know what SDK to install"
  echo "example export AI_CHIP=/home/ubuntu/.ai_chip"
  exit
fi

. aws_neuron_venv_pytorch/bin/activate
python -m pip config set global.extra-index-url https://pip.repos.neuron.amazonaws.com
python -m pip install neuronx-cc==2.* torch-neuronx torchvision

echo "neuron" > $AI_CHIP
deactivate

./prep_dataset.sh
