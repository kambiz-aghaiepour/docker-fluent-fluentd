FROM fluent/fluentd:v0.14.11
MAINTAINER Kambiz Aghaiepour <kambiz@aghaiepour.com>
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

# cutomize following "gem install fluent-plugin-..." line as you wish

USER root
RUN apk --no-cache add sudo build-base ruby-dev && \
    sudo -u fluent gem install fluent-plugin-elasticsearch fluent-plugin-record-reformer fluent-plugin-secure-forward && \
    rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && sudo -u fluent gem sources -c && \
    apk del sudo build-base ruby-dev

EXPOSE 24284

USER fluent
CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
