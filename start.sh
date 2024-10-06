if [ "$EUID" -ne 0 ]; then 
  echo "Pls, try run with sudo"
  exit
fi

echo "Install dependents"

apt-get update
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


docker --version
docker compose version

echo "Pull latest code from github and Run Projest"

REPO_URL="https://github.com/dsgolovin/shvirtd-example-python.git"
TARGET_DIR="/opt/shvirtd-example-python"

git clone "$REPO_URL" "$TARGET_DIR"

cd "$TARGET_DIR" || exit

docker compose up -d