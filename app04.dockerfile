FROM ubuntu:latest

RUN apt-get update && apt-get install -y dumb-init ssh python3

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["service", "ssh", "start", "-D"]
