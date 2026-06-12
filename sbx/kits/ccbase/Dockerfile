FROM docker/sandbox-templates:claude-code-docker

# Install dependencies not managed by mise
RUN sudo apt update -y && sudo apt install -y \
  build-essential \
  direnv \
  && echo 'eval "$(direnv hook bash)"' >> /etc/sandbox-persistent.sh

# Takumi Guard
ENV NPM_CONFIG_REGISTRY=https://npm.flatt.tech/ \
  PIP_INDEX_URL=https://pypi.flatt.tech/simple/ \
  UV_DEFAULT_INDEX=https://pypi.flatt.tech/simple/ \
  GOPROXY=https://golang.flatt.tech \
  MISE_PIPX_REGISTRY_URL=https://pypi.flatt.tech/simple/{}/

# Install mise
RUN sudo apt update -y && sudo apt install -y curl \
  && sudo install -dm 755 /etc/apt/keyrings \
  && curl -fSs https://mise.en.dev/gpg-key.pub | sudo tee /etc/apt/keyrings/mise-archive-keyring.asc 1> /dev/null \
  && echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.asc] https://mise.en.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list \
  && sudo apt update -y \
  && sudo apt install -y mise \
  && echo 'eval "$(mise activate bash)"' >> /etc/sandbox-persistent.sh
ENV MISE_MINIMUM_RELEASE_AGE=7d

# Install GitHub CLI
RUN (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && sudo mkdir -p -m 755 /etc/apt/sources.list.d \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y

# Install AWS CLI v2
RUN ARCH="$(uname -m)" && curl "https://awscli.amazonaws.com/awscli-exe-linux-$ARCH.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && sudo ./aws/install \
  && rm -rf aws awscliv2.zip

ENV AWS_PAGER=""
