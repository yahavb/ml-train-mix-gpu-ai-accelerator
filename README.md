# ml-train-mix-gpu-ai-accelerator

## Build app image
```
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
export AWS_REGION=us-west-2
export BASE_REPO=perceiver
export BASE_TAG=multiarch-ubuntu
export BASE_ARM_TAG=arm64
export BASE_AMD_TAG=amd64
export GITHUB_BRANCH=main
export GITHUB_USER=yahavb
export GITHUB_REPO=ml-train-mix-gpu-ai-accelerator
```

## Deploy perciver training on EKS

* Deploy [EKS cluster and Karpenter](https://karpenter.sh/docs/getting-started/getting-started-with-karpenter/)
* Optional - Deploy [Container Insights on Amazon EKS](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Container-Insights-setup-EKS-quickstart.html)
* Deploy Trainuim karpenter provisioner 
```bash
kubectl apply -f amd-neuron-provisioner.yaml
```
* Enable [Neuron device plugin in Kubernetes](https://awsdocs-neuron.readthedocs-hosted.com/en/latest/containers/tutorials/k8s-neuron-device-plugin.html) 
```bash
kubectl apply -f k8s-neuron-device-plugin-rbac.yml
kubectl apply -f k8s-neuron-device-plugin-ds.yaml
```
* Deploy the perciever training and evaluation on Trainuim instances
```bash
kubectl apply -f perceiver-trn-job.yaml
```

