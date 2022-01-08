FROM ubuntu

ENV BASE_DIR="/set"

RUN set -o errexit -o nounset \
    && mkdir -p $BASE_DIR/bin \
    && cd $BASE_DIR 
COPY docker-entrypoint.sh $BASE_DIR/bin
COPY set $BASE_DIR/bin
COPY setfinder $BASE_DIR/bin
COPY genesis.json $BASE_DIR
COPY nodes.txt $BASE_DIR

WORKDIR $BASE_DIR/bin/

ENTRYPOINT ["./docker-entrypoint.sh"]
