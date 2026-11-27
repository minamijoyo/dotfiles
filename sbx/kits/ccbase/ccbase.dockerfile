FROM sbx/shell

# Install dependencies not managed by mise
RUN sudo apt update -y && sudo apt install -y \
  build-essential \
  direnv \
  vim \
  && echo 'eval "$(direnv hook bash)"' >> /etc/sandbox-persistent.sh

# Takumi Guard
ENV NPM_CONFIG_REGISTRY=https://npm.flatt.tech/ \
  PIP_INDEX_URL=https://pypi.flatt.tech/simple/ \
  GOPROXY=https://golang.flatt.tech \
  MISE_PIPX_REGISTRY_URL=https://pypi.flatt.tech/simple/{}/

# Install mise
RUN sudo apt update -y && sudo apt install -y extrepo \
  && sudo extrepo enable mise \
  && sudo apt update && sudo apt install -y mise \
  && echo 'eval "$(mise activate bash)"' >> /etc/sandbox-persistent.sh
ENV MISE_MINIMUM_RELEASE_AGE=7d

# Customize env vars
RUN echo 'export PATH="$PATH:$HOME/go/bin"' >> /etc/sandbox-persistent.sh
RUN echo 'export UV_PROJECT_ENVIRONMENT="$(mise where python)"' >> /etc/sandbox-persistent.sh

# Copy configuration files
COPY --chown=agent:agent files/home/ /home/agent/
