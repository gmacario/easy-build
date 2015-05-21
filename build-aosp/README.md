build-aosp
==========

This project helps rebuilding firmware images of the [Android Open Source Project](http://source.android.com/source/index.html).

WARNING: Still experimental, use at your own risk!

Running from Docker image repository

Build the image

```
$ ./build.sh
```

Run the image

```
$ ./run.sh
```

You must then change to user `build`

```
# su - build
```

Then do the usual `repo init`, `repo sync`, etc.
