#!/bin/bash -x
#
PIP="python3.8 -m pip"

if poetry search torch-neuronx | grep neuronx &>/dev/null; then 
  ${PIP} config set global.extra-index-url $PIP_REPO 
  ${PIP} install --force-reinstall torch-neuronx==1.13.0.* neuronx-cc==2.* --extra-index-url $PIP_REPO
fi 
