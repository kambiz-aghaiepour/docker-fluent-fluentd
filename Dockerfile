FROM centos

COPY fluentd.repo /etc/yum.repos.d/fluentd.repo
RUN yum install -y td-agent

ENV PATH=/opt/td-agent/embedded/bin:$PATH
RUN gem install fluent-plugin-elasticsearch
RUN gem install fluent-plugin-beats
ENV TD_AGENT_NAME=td-agent
ENV TD_AGENT_HOME=/opt/td-agent
ENV TD_AGENT_DEFAULT=/etc/sysconfig/td-agent
ENV TD_AGENT_USER=td-agent
ENV TD_AGENT_GROUP=td-agent
ENV TD_AGENT_RUBY=/opt/td-agent/embedded/bin/ruby
ENV TD_AGENT_BIN_FILE=/usr/sbin/td-agent
ENV TD_AGENT_LOG_FILE=/var/log/td-agent/td-agent.log
ENV TD_AGENT_PID_FILE=/var/run/td-agent/td-agent.pid
ENV TD_AGENT_LOCK_FILE=/var/lock/subsys/td-agent
ENV TD_AGENT_OPTIONS="--use-v1-config"
ENV LD_PRELOAD=${TD_AGENT_HOME}/embedded/lib/libjemalloc.so
ENV TD_AGENT_ARGS="${TD_AGENT_BIN_FILE} --log ${TD_AGENT_LOG_FILE} ${TD_AGENT_OPTIONS}"

CMD ["/opt/td-agent/embedded/bin/ruby", "/usr/sbin/td-agent", "--log", "/var/log/td-agent/td-agent.log", "--use-v1-config"]


