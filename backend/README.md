# "Elitememers" Backend
This is the backend of the DoHack2018 "EliteMemers" Project. It serves a graphql api at `/graphql` and a graphiql frontend at `/`.

We use SpringBoot, Hibernate, Jpa, H2, Maven, spring-graphql, graphql-java-tools, graphql-java, graphiql, lombok, mapstruct.

## Build
Build and run this like any spring boot application. `mvn clean springBoot:run -DskipTests`

## Deployment
During our hackathon this project was deployed as jar to a Pivotal Web Services 1GB instance via CloudFoundry.