FROM ubuntu

ENV PATH="/root/.local/bin:${PATH}"
ENV VIRTUAL_ENV=/opt/venv

WORKDIR /app

RUN apt-get update && apt-get install -y \
  python3 \
  pipx \
  bash \
  ssh \
  iputils-ping \
  net-tools \
  dumb-init && \
  \
  python3 -m venv $VIRTUAL_ENV && \
  . $VIRTUAL_ENV/bin/activate && \
  \
  pip3 install ansible ansible-core ara && \
  ansible-galaxy collection install community.general && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH="${VIRTUAL_ENV}/bin:${PATH}"

# RUN export ANSIBLE_ACTION_PLUGINS=$(python3 -m ara.setup.action_plugins) && \
#   export ANSIBLE_CALLBACK_PLUGINS=$(python3 -m ara.setup.callback_plugins) && \
#   export ANSIBLE_LOOKUP_PLUGINS=$(python3 -m ara.setup.lookup_plugins)

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["tail", "-f", "/dev/null"]
