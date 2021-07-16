FROM openjdk:8
WORKDIR /app
COPY ./target/spring-petclinic-rest-2.4.2.jar .
COPY ./application.properties .
ENTRYPOINT ["java","-jar","spring-petclinic-rest-2.4.2.jar","--spring.config.location=application.properties"]