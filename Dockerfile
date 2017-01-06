FROM centos

COPY fluentd.repo /etc/yum.repos.d/fluentd.repo
RUN yum install -y td-agent

ENV PATH=/opt/td-agent/embedded/bin:$PATH
RUN gem install fluent-plugin-elasticsearch
RUN gem install fluent-plugin-beats
RUN systemctl start td-agent.service

CMD ["/bin/bash"]

