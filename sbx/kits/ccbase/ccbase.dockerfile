FROM sbx/shell

# Install dependencies not managed by mise
RUN sudo apt update -y && sudo apt install -y \
  build-essential \
  direnv

# Install mise
RUN sudo apt update -y && sudo apt install -y extrepo \
  && sudo extrepo enable mise \
  && sudo apt update && sudo apt install -y mise

# Copy configuration files
COPY --chown=agent:agent files/home/ /home/agent/
