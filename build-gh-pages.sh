#!/bin/bash

REPO_URL=
REPO_DIR=
PAGES_DIR=
BUILD_FILE=

GROUP_ID=
ARTIFACT_ID=
VERSION=

# Delete any existing temporary website clone
cd ..
rm -rf $PAGES_DIR

# Checkout and track the gh-pages branch
git clone -b gh-pages --single-branch $REPO_URL $PAGES_DIR

# Delete everything
cd $PAGES_DIR
rm -rf *

# Copy artifacts
cd ../$REPO_DIR
mvn install:install-file -Dfile=$BUILD_FILE -DgroupId=$GROUP_ID -DartifactId=$ARTIFACT_ID -Dversion=$VERSION -Dpackaging=aar -DlocalRepositoryPath=../$PAGES_DIR

# Create pretty directory listing
cd ../$PAGES_DIR
for f in $(find ./ \( -o -name build -o -name .git -o -name .gradle \) -prune -o -type d); do
  (
    echo "<html><body><h1>Directory listing</h1><hr/><pre>"
    ls -1p "${f}" | grep -v "^\./$" | grep -v "index.html" | awk '{ printf "<a href=\"%s\">%s</a>\n",$1,$1 }' 
    echo "</pre></body></html>"
  ) > "${f}/index.html"
done

# Stage all files in git and create a commit
git add .
git add -u
git commit -m "Website at $(date)"

# Push the new files up to GitHub
git push origin gh-pages

# Delete our temp folder
cd ..
rm -rf $PAGES_DIR
