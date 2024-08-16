# Stage 1 Build
FROM maven AS builder
WORKDIR /usr/src/maven
COPY . .
RUN mvn clean package
#stage 2 Deployment
FROM tomcat
WORKDIR /usr/local/tomcat
RUN cp -pr ./webapps.dist/* ./webapps
RUN rm -rf ./webapps/ROOT*
COPY --from=builder /usr/src/maven/target/*.war ./webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]

