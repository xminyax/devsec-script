#!/bin/sh

PWD_PATH=$(pwd)
GITLEAKS_PATH=$PWD_PATH/gitleaks

if ! command -v "$GITLEAKS_PATH" >/dev/null 2>&1; then
  echo "gitleaks is not installed. Checking OS for installation..."

  OS=$(uname -s | tr '[:upper:]' '[:lower:]')

  if [[ "$OS" == "darwin" ]]; then
    GITLEAKS_VERSION="8.16.4"
  elif [[ "$OS" == "linux" ]]; then
    GITLEAKS_VERSION="8.16.4"
  else
    echo "Unsupported operating system: $OS"
    exit 1
  fi

  echo "Installing gitleaks $GITLEAKS_VERSION..."
  curl -sSL -o gitleaks.tar.gz "https://github.com/gitleaks/gitleaks/releases/download/v$GITLEAKS_VERSION/gitleaks_"$GITLEAKS_VERSION"_"$OS"_x64.tar.gz"
  tar -xzf gitleaks.tar.gz  "gitleaks"
  chmod +x "$GITLEAKS_PATH"
  rm gitleaks.tar.gz

  if ! grep -q "/gitleaks" $PWD_PATH/.gitignore; then
    echo "Adding gitleaks binary to .gitignore..."
    echo "/gitleaks" >> $PWD_PATH/.gitignore
  fi
fi

"$GITLEAKS_PATH" detect --source=. --report-path=report.txt

if [ $? -eq 0 ]; then
  echo "No secrets found. Commit allowed."
  exit 0
else
  echo "Secrets found in the code. Commit rejected."
  echo "Please remove the secrets before committing."
  exit 1
fi
