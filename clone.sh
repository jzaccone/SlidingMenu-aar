wget --no-check-certificate https://codeload.github.com/minakov/aar-quickstart/zip/master -O aar-quickstart.zip
unzip aar-quickstart.zip
rm aar-quickstart.zip
mv aar-quickstart-master aar-quickstart
cd aar-quickstart
chmod +x build-gh-pages.sh
mv SCELETON.md README.md
rm clone.sh
git init
