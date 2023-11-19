FROM oak/kafka-node:latest


LABEL org.opencontainers.image.authors="allex.carvalho@gmail.com" \
      description="kafka controller - on top of kafka-node image which is an ubuntu and java"


VOLUME ["/tmp/kraft-controller-logs"]


COPY ./entrypoint.sh .
RUN chmod u+x entrypoint.sh


ENTRYPOINT [ "./entrypoint.sh" ]


LABEL version="0.1.0"