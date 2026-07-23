# Bash login shell — source environment + interactive config
source ~/.profile
export PROFILE_SOURCED=1
source ~/.bashrc
# Add .NET Core SDK tools + local SDK (takes priority over system dotnet)
export PATH="/home/mikus/.dotnet:$PATH:/home/mikus/.dotnet/tools"
. "$HOME/.cargo/env"
