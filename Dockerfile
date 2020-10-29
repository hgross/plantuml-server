FROM ubuntu:xenial
# we need to rely on xenial, since they have graphviz in the desired version available

ARG PLANTUML_SERVER_VERSION=v1.2020.19
ARG JETTY_RUNNER_VERSION=9.4.33.v20201020

# we need to ensure graphviz 2.38.0 since higher versions are known to cause trouble with PlantUML
RUN apt-get update && apt-get install -y --no-install-recommends graphviz=2.38.0-12ubuntu2.1 fonts-wqy-zenhei maven wget && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN mkdir -p dependency

# if we ever need it - xenial support will run out eventually
#RUN git clone https://gitlab.com/graphviz/graphviz.git
#RUN cd graphviz && ./configure && make && make install

EXPOSE 8080
ENV HOME /app
RUN wget https://github.com/plantuml/plantuml-server/releases/download/$PLANTUML_SERVER_VERSION/plantuml-$PLANTUML_SERVER_VERSION.war && cp plantuml-$PLANTUML_SERVER_VERSION.war plantuml.war

# download jetty-runner artifact
# note that it is obsolete ... don't use this in production
RUN mvn org.apache.maven.plugins:maven-dependency-plugin:2.1:get \
    -DrepoUrl=url \ 
    -Dartifact=org.eclipse.jetty:jetty-runner:$JETTY_RUNNER_VERSION

RUN cp $(find / | grep "jetty-runner-${JETTY_RUNNER_VERSION}.jar$") dependency/jetty-runner.jar && chmod a+rx dependency/*

CMD java -Djetty.contextpath=/ -jar dependency/jetty-runner.jar plantuml.war