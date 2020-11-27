# plantuml-server-docker
![Docker](https://github.com/hgross/plantuml-server/workflows/Docker/badge.svg)

Provides a PlantUML server docker image that uses GraphViz 2.38.0 as a dependency.
Made to circumvent issues with PlantUML and newer versions of GraphViz.
There is https://github.com/plantuml/plantuml-server but as of 2020-10-29 they also suffer from the known issues.
This image downloads the plantuml-server release from github and deploys it into a jetty-runner.


## Configuration options
|ENV variable|Description|Default|valid values|
|-|-|-|-|
|PLANTUML_LIMIT_SIZE|The size limit (pixels) for plant uml diagrams (PlantUML configuration)|16384|[see PlantUML docs](https://plantuml.com/de/faq)|
|JAVA_MIN_HEAP_SIZE|The java Xms setting to control initial heap size of the plantuml server process|64M|[check this link](https://alvinalexander.com/blog/post/java/java-xmx-xms-memory-heap-size-control/)|
|JAVA_MAX_HEAP_SIZE|The java Xmx setting to control max heap size of the plantuml server process|4G|[check this link](https://alvinalexander.com/blog/post/java/java-xmx-xms-memory-heap-size-control/)|



## Download and run 
```bash
docker run -d -p 8080:8080 hgross/plantuml-server
```


## Build and run locally
```bash
# build and run locally
docker run -p 8080:8080 -it $(docker build -q .) 
```


## VSCode PlantUML config
Install the [PlantUML VSCode Extension](https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml).
Add the follwing to your user visual studio code user settings json.


```json
{
    "plantuml.server": "http://127.0.0.1:8080",
    "plantuml.render": "PlantUMLServer" 
}
```