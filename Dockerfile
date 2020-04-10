FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
WORKDIR /usr/
COPY pom.xml /usr/
COPY src /usr/src/
RUN mvn package
FROM tomcat:9.0-jre8-alpine
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=MAVEN_TOOL_CHAIN /usr/target/*.war /usr/local/tomcat/webapps/Spring3HibernateApp.war
CMD ["catalina.sh","run"]
