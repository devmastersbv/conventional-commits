FROM alpine/git
RUN apk add --no-cache bash
COPY generate-tag.sh .
ENTRYPOINT ["/bin/bash","generate-tag.sh"]
