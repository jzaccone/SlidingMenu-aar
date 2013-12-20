aar-quickstart
==============

Maven repository on [GitHub Pages](http://pages.github.com/)

How to use
========

[SlidingMenu](https://github.com/jfeinstein10/SlidingMenu/)

Create A Repo
--------

Repository name: SlidingMenu-aar
Description: SlidingMenu library built with gradle in aar format for usage with android gradle build system

Download sceleton
--------

```bash
$ wget --no-check-certificate https://codeload.github.com/minakov/aar-quickstart/zip/master -O aar-quickstart.zip
$ unzip aar-quickstart.zip
$ rm aar-quickstart.zip
$ mv aar-quickstart-master SlidingMenu-aar
$ chmod +x build-gh-pages.sh
$ mv SCELETON.md README.md
```

Cloning library
--------

```bash
$ cd SlidingMenu-aar
$ git init
$ git submodule add https://github.com/jfeinstein10/SlidingMenu.git
```

Edit build.gradle
--------

```groovy
android {
    ...
    sourceSets {
        main {
            manifest.srcFile 'SlidingMenu/library/AndroidManifest.xml'
            java.srcDirs = ['SlidingMenu/library/src']
            res.srcDirs = ['SlidingMenu/library/res']
        }
    }
}
```

Compile
--------

```bash
$ ./gradlew clean build
```

When build is finished aar file will be located in `build/libs`.

Edit build-gh-pages.sh
--------

```bash
REPO_URL=https://github.com/minakov/SlidingMenu-aar.git
REPO_DIR=SlidingMenu-aar
PAGES_DIR=SlidingMenu-aar-pages

BUILD_FILE=build/libs/SlidingMenu-aar.aar
GROUP_ID=com.jeremyfeinstein.slidingmenu
ARTIFACT_ID=library
VERSION="1.3"
```

> See `groupId` `artifactId` and `version` in `pom.xml`

Push your commit
--------

```bash
$ git add .
$ git commit -m "init commit"
$ git remote add origin https://github.com/minakov/SlidingMenu-aar.git
$ git push origin master
```

Creating Project Pages
--------

```bash
$ cd ..
$ rm -rf SlidingMenu-aar
$ git clone https://github.com/minakov/SlidingMenu-aar.git
$ cd SlidingMenu-aar
$ git checkout --orphan gh-pages
$ git rm -rf .
$ echo "" > index.html
$ git add index.html
$ git commit -a -m "First pages commit"
$ git push origin gh-pages
$ cd ..
$ rm -rf SlidingMenu-aar
```

Build pages
--------

```bash
$ git clone https://github.com/minakov/SlidingMenu-aar.git
$ cd SlidingMenu-aar
$ git submodule update --init
$ ./gradlew clean build
$ build-gh-pages.sh
```
