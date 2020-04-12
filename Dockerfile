FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
WORKDIR /usr/
COPY pom.xml /usr/
COPY src /usr/src/
RUN mvn package
FROM tomcat:9.0-jre8-alpine
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=MAVEN_TOOL_CHAIN /usr/target/*.war /usr/local/tomcat/webapps/Spring3HibernateApp.war
CMD ["catalina.sh","run"]
FROM sushanttickoo22/sonar
# Separating ENTRYPOINT and CMD operations allows for core execution variables to
# be easily overridden by passing them in as part of the `docker run` command.
# This allows the default /usr/src base dir to be overridden by users as-needed.
ENTRYPOINT ["sonar-scanner"]
CMD ["-Dsonar.projectBaseDir=/usr/src"]
