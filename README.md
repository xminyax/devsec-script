# devsec-script

1. Copy the pre-commit.sh file to /<project name>/.git/hooks
```
cp pre-commit.sh /<project name>/.git/hooks/pre-commit
```
2. Assign usage permissions 
```
chmod 0744 /<project name>/.git/hooks/pre-commit
```
3. When you create a commit, it will check for secrets