Android ARchive skeleton
========

Build any android library project with android gradle for usage with android gradle build system. Publish artifacts on [GitHub Pages](http://pages.github.com/).

How to use
========

For example we use [SlidingMenu](https://github.com/jfeinstein10/SlidingMenu/) library

Create a github repo
--------

* Repository name: SlidingMenu-aar
* Description: SlidingMenu library built with gradle in aar format for usage with android gradle build system

Download sceleton
--------

```bash
$ wget --no-check-certificate -O - https://raw.github.com/minakov/aar-quickstart/master/clone.sh | bash
$ mv aar-quickstart SlidingMenu-aar
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

Edit build-gh-pages.sh and README.md
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
$ git commit -a -m "init commit"
$ git remote add origin https://github.com/minakov/SlidingMenu-aar.git
$ git push origin master
```

Creating github project pages
--------

```bash
$ git checkout --orphan gh-pages
$ git rm -rf .
$ echo "" > index.html
$ git commit -a -m "First pages commit"
$ git push origin gh-pages
$ cd ..
$ rm -rf SlidingMenu-aar
```

Build maven repository 
--------

```bash
$ git clone https://github.com/minakov/SlidingMenu-aar.git
$ cd SlidingMenu-aar
$ git submodule update --init
$ ./gradlew clean build
$ build-gh-pages.sh
$ cd ..
$ rm -rf SlidingMenu-aar
```

Credits
========

* https://github.com/mente/facebook-api-android-aar
* https://github.com/square/spoon
* http://blog.kaltepoth.de/posts/2010/09/06/github-maven-repositories.html
* http://jedicoder.blogspot.com/2011/11/automated-gradle-project-deployment-to.html

License
========

    Copyright 2013 Vladimir Minakov

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
