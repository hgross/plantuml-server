# plantuml-server-docker
Provides a PlantUML server docker image that uses GraphViz 2.38.0 as a dependency.
Made to circumvent issues with PlantUML and newer versions of GraphViz.
There is https://github.com/plantuml/plantuml-server but as of 2020-10-29 they also suffer from the known issues.
This image downloads the plantuml-server release from github and deploys it into a jetty-runner.

## Build and run locally
```bash
# build and run locally
docker run -p 8080:8080 -it $(docker build -q .) 
```

## VSCode PlantUML config
Add the follwing to your user settings json
```json
{
    "plantuml.server": "http://127.0.0.1:8080",
    "plantuml.render": "PlantUMLServer" 
}
```