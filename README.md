# chartmuseum/testbed

[![Codefresh build status]( https://g.codefresh.io/api/badges/pipeline/chartmuseum/chartmuseum%2Ftestbed%2Fmaster?type=cf-1)]( https://g.codefresh.io/public/accounts/chartmuseum/pipelines/chartmuseum/testbed/master)

`chartmuseum/testbed:latest`

The Docker image contains everything needed to build, test, and release ChartMuseum, including

- Bash, Git, Make
- Dep
- Helm CLI
- Robot Framework
- AWS CLI


## How to use


Simply run the docker image, mounting the ChartMuseum source at `/go/src/github.com/helm/chartmuseum`:

```
git clone git@github.com:helm/chartmuseum.git

docker run --rm -it --entrypoint bash \
  -v $(pwd)/chartmuseum:/go/src/github.com/helm/chartmuseum \
  chartmuseum/testbed:latest \
  -c 'make test'
```

To test cloud providers, pass in credentials (as env vars or in volumes, depending on provider) as well as the necessary test vars. A full list of expected test vars can be found [here](https://github.com/helm/chartmuseum/blob/master/scripts/setup_test_environment.sh#L4).
