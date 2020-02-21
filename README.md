# my-azure-pipelines-agent

This repository contains the definition of my custom Azure Pipelines agent as a Docker image.
I'm installing Docker, Azure CLI and Terraform on that agent.

## Run the agent on Docker

```
AZP_TOKEN=FIXME
AZP_URL=https://dev.azure.com/FIXME
AZP_AGENT_NAME=myadoagent

docker run \
  -e AZP_URL=$AZP_URL \
  -e AZP_TOKEN=$AZP_TOKEN \
  -e AZP_AGENT_NAME=$AZP_AGENT_NAME \
  -it mabenoit/ado-agent:latest
```

> Note: if you need to run Docker on that Docker agent, you will need to add that parameter in the above command: `-v /var/run/docker.sock:/var/run/docker.sock`

## Run the agent on Kubernetes

```
AZP_TOKEN=FIXME
AZP_URL=https://dev.azure.com/FIXME
AZP_AGENT_NAME=myadoagent
AZP_POOL=myadoagent

kubectl create secret generic azp \
  --from-literal=AZP_URL=$AZP_URL \
  --from-literal=AZP_TOKEN=$AZP_TOKEN \
  --from-literal=AZP_AGENT_NAME=$AZP_AGENT_NAME \
  --from-literal=AZP_POOL=$AZP_POOL

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ado-agent
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ado-agent
  template:
    metadata:
      labels:
        app: ado-agent
    spec:
      containers:
        - name: ado-agent
          image: mabenoit/ado-agent:latest
          env:
            - name: AZP_URL
              valueFrom:
                secretKeyRef:
                  name: azp
                  key: AZP_URL
            - name: AZP_TOKEN
              valueFrom:
                secretKeyRef:
                  name: azp
                  key: AZP_TOKEN
            - name: AZP_AGENT_NAME
              valueFrom:
                secretKeyRef:
                  name: azp
                  key: AZP_AGENT_NAME
            - name: AZP_POOL
              valueFrom:
                secretKeyRef:
                  name: azp
                  key: AZP_POOL
          volumeMounts:
            - mountPath: /var/run/docker.sock
              name: docker-socket-volume
      volumes:
        - name: docker-socket-volume
          hostPath:
            path: /var/run/docker.sock
EOF
```

## Resources

- [Run an agent in Docker](https://docs.microsoft.com/azure/devops/pipelines/agents/docker)
- [Ephemeral Pipelines Agents](https://github.com/microsoft/azure-pipelines-ephemeral-agents)
- [Elastic Self-hosted Agent Pools (coming soon)](https://github.com/microsoft/azure-pipelines-agent/blob/master/docs/design/byos.md)
- [Load Testing Pipeline with JMeter, ACI and Terraform](https://docs.microsoft.com/samples/azure-samples/jmeter-aci-terraform/jmeter-aci-terraform/)
