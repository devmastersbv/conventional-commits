FROM alpine:latest
RUN apk add --no-cache git bash && git config --global --add safe.directory /git
WORKDIR /git
COPY generate-tag.sh .
ENTRYPOINT ["/bin/bash","generate-tag.sh"]
