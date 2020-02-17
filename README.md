# my-azure-pipelines-agent

```
docker run \
  -e AZP_URL=<Azure DevOps instance> \
  -e AZP_TOKEN=<PAT token> \
  -e AZP_AGENT_NAME=myadoagent \
  mabenoit/ado-agent:latest
```

## Resources

- [Run an agent in Docker](https://docs.microsoft.com/azure/devops/pipelines/agents/docker)
