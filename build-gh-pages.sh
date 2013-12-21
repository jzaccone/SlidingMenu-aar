#!/bin/bash

HOME_DIR=$PWD
DIR=$(basename $PWD)-pages
URL=$(git config --get remote.origin.url)

# Delete any existing temporary website clone
cd ..
rm -rf $DIR

# Checkout and track the gh-pages branch
git clone $URL $DIR

# Delete everything
cd $DIR
PAGES_DIR=$PWD

git checkout --orphan gh-pages
rm -rf .gitignore
rm -rf .gitmodules
rm -rf *

# Build artifacts
cd $HOME_DIR
./gradlew -Dorg.gradle.project.repoDir="$PAGES_DIR" uploadArchives

# Create pretty directory listing
cd $PAGES_DIR
for DIR in $(find ./ \( -name build -o -name .git -o -name .gitignore \) -prune -o -type d); do
  (
    echo "<html><body><h1>Directory listing</h1><hr/><pre>"
    ls -1p "${DIR}" | grep -v "^\./$" | grep -v "index.html" | awk '{ printf "<a href=\"%s\">%s</a>\n",$1,$1 }' 
    echo "</pre></body></html>"
  ) > "${DIR}/index.html"
done

# Stage all files in git and create a commit
git add --all .
git commit -m "Website at $(date)"

# Push the new files up to GitHub
git push origin gh-pages

# Delete our temp folder
cd ..
rm -rf $DIR
