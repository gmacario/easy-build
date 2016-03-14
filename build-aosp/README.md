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

Then logged as build@container you should do the usual `repo init`, `repo sync`, etc.

<!-- EOF -->
