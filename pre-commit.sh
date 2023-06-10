#!/bin/sh

#git clone https://github.com/gitleaks/gitleaks.git
#cd gitleaks
#make build

~/gitleaks/gitleaks detect --source=. --report-path=report.txt

if [ $? -eq 0 ]; then
  echo "No secrets found. Commit allowed."
  exit 0
else
  echo "Secrets found in the code. Commit rejected."
  echo "Please remove the secrets before committing."
  exit 1
fi