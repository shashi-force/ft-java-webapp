FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
WORKDIR /usr/
COPY pom.xml /usr/
COPY src /usr/src/
RUN mvn package
FROM tomcat:9.0-jre8-alpine
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=MAVEN_TOOL_CHAIN /usr/target/*.war /usr/local/tomcat/webapps/Spring3HibernateApp.war
CMD ["catalina.sh","run"]
FROM openjdk:8

LABEL maintainer="Sushant Tickoo"

RUN apt-get update
RUN apt-get install -y curl git tmux htop maven sudo

# Install Node - allows for scanning of Typescript
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN sudo apt-get install -y nodejs build-essential

RUN curl --insecure -o ./sonarscanner.zip -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.0.0.1744-linux.zip && \
	unzip sonarscanner.zip && \
	rm sonarscanner.zip && \
	mv sonar-scanner-4.0.0.1744-linux /usr/lib/sonar-scanner && \
	ln -s /usr/lib/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner

ENV SONAR_RUNNER_HOME=/usr/lib/sonar-scanner

COPY sonar-runner.properties /usr/lib/sonar-scanner/conf/sonar-scanner.properties

# Separating ENTRYPOINT and CMD operations allows for core execution variables to
# be easily overridden by passing them in as part of the `docker run` command.
# This allows the default /usr/src base dir to be overridden by users as-needed.
ENTRYPOINT ["sonar-scanner"] 
CMD ["-Dsonar.projectBaseDir=/usr/src"]
