# my-azure-pipelines-agent

This repository contains the definition of my custom Azure Pipelines agent as a Docker image.
I'm installing Docker, Azure CLI, Kubectl and Terraform on that agent.

## Run the agent on Docker

```
docker run \
  -e AZP_URL=<Azure DevOps instance> \
  -e AZP_TOKEN=<PAT token> \
  -e AZP_AGENT_NAME=myadoagent \
  mabenoit/ado-agent:latest
```

> Note: if you need to run Docker on that Docker agent, you will need to add that parameter in the above command: `-v /var/run/docker.sock:/var/run/docker.sock`

## Run the agent on Kubernetes

FIXME

## Resources

- [Run an agent in Docker](https://docs.microsoft.com/azure/devops/pipelines/agents/docker)
- [Ephemeral Pipelines Agents](https://github.com/microsoft/azure-pipelines-ephemeral-agents)
