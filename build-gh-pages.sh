#!/bin/bash

DIR={LIBRARY}-aar-pages

# Delete any existing temporary website clone
cd ..
rm -rf $DIR

# Checkout and track the gh-pages branch
git clone -b gh-pages --single-branch https://github.com/minakov/{LIBRARY}-aar.git $DIR

# Delete everything
cd $DIR
rm -rf *

# Copy artifacts
cd ../{LIBRARY}-aar
mvn install:install-file -Dfile=build/libs/{LIBRARY}-aar.aar -DgroupId={LIBRARY} -DartifactId={LIBRARY} -Dversion="1.0" -Dpackaging=aar -DlocalRepositoryPath=../$DIR

# Create pretty directory listing
cd ../$DIR
for DIR in $(find ./ \( -name {LIBRARY} -o -name build -o -name .git -o -name .gradle \) -prune -o -type d); do
  (
    echo "<html><body><h1>Directory listing</h1><hr/><pre>"
    ls -1p "${DIR}" | grep -v "^\./$" | grep -v "index.html" | awk '{ printf "<a href=\"%s\">%s</a>\n",$1,$1 }' 
    echo "</pre></body></html>"
  ) > "${DIR}/index.html"
done

# Stage all files in git and create a commit
git add .
git add -u
git commit -m "Website at $(date)"

# Push the new files up to GitHub
git push origin gh-pages

# Delete our temp folder
cd ..
rm -rf $DIR
