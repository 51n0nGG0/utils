@ECHO OFF

SET /p RepoURL="Enter the repository url: "
SET /p UserName="Enter the user name: "
SET /p UserEmail="Enter the user email: "

IF NOT EXIST ".git" (
    git init
)

git config user.name "%UserName%"
git config user.email "%UserEmail%"

git remote add origin %RepoURL%

FOR /R %%f IN (*) DO (
    IF NOT "%%~nxf" == "git-init-repository.cmd" (
        git add "%%f"
    )
)

git commit -m "Upload existing content"

git branch -m master main

git config credential.helper wincred

git pull origin main --allow-unrelated-histories

git push -u origin main