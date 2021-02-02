FROM openjdk:8-jdk-alpine

RUN apk add tzdata
RUN cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime

ENV APPNM sb-api-sample

ENV ROOT_PATH /data/$APPNM
RUN mkdir -p $ROOT_PATH

COPY $APPNM.war $ROOT_PATH/$APPNM.war
COPY conf $ROOT_PATH/conf

ARG PROFILES
ARG LOCATION
ARG MAPPER
ENV JAVA_OPTS "-Dspring.profiles.active=$PROFILES -Dspring.config.location=classpath:/application.yml,$ROOT_PATH/$LOCATION -Dmybaits.mapper=$ROOT_PATH/$MAPPER"
#ENV JAVA_OPTS "-Dspring.profiles.active=$PROFILES"

ENTRYPOINT java $JAVA_OPTS -jar $ROOT_PATH/$APPNM.war