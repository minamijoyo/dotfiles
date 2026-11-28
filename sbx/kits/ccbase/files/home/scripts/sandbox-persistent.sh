eval "$(mise activate bash)"
eval "$(direnv hook bash)"
export PATH="$PATH:$HOME/go/bin"
export UV_PROJECT_ENVIRONMENT="$(mise where python)"

# Takumi Guard
export NPM_CONFIG_REGISTRY=https://npm.flatt.tech/
export PIP_INDEX_URL=https://pypi.flatt.tech/simple/
export GOPROXY=https://golang.flatt.tech
export MISE_PIPX_REGISTRY_URL=https://pypi.flatt.tech/simple/{}
