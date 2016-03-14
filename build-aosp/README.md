build-aosp
==========

This project helps rebuilding firmware images of the [Android Open Source Project](http://source.android.com/source/index.html).

WARNING: Still experimental, use at your own risk!

### Build the Docker image

```
$ docker build -t gmacario/build-aosp build-aosp/
```

### Run the Docker image

```
$ docker run -ti gmacario/build-aosp
```

Then logged as build@container you may follow the instructions at https://source.android.com/source/downloading.html:

```
$ git config --global user.name "Your Name"
$ git config --global user.email "you@example.com"
$ git config --global color.ui auto
$ mkdir -p ~/aosp && cd ~/aosp
$ repo init -u https://android.googlesource.com/platform/manifest -b android-4.0.1_r1
$ repo sync
```

<!-- EOF -->
