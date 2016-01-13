## Tensorflow

The first step is to build Tensorflow which is not trivial on XC system.
Tensorflow uses Bazel as a build system which is in Beta version meaning that it requires a lot of tricks to have it working.
All necessary files to compile Tensorflows are in [tensorflow/build](https://github.com/eth-cscs/bigdata/blob/master/tensorflows/build)

Set-up modules:
```
module purge
module load cudatoolkit/7.0.28-1.0502.10742.5.1
module load gcc/4.8.2
module load java/jdk1.8.0_51
```
Note that you can use a version of GCC up to 4.10.

To build Bazel you need to download version [0.1.1](https://github.com/bazelbuild/bazel/archive/0.1.1.tar.gz).

1. You will need to modify Bazel by applying the following patch:
`patch -p1 < FixBazelToBuild.patch`
- This patch will help Bazel to accept the Java version of the module, add a LDFLAGS for adding the shared library path into the binaries, and setup some variables to use gcc 4.8.2 installed in a non-standard path.

2. Export this env. variables:
`export LDFLAGS=-Wl,-rpath,/opt/gcc/4.8.2/snos/lib64`

3. Then compile it:
`./compile.sh build`

If it succeed you will have it will be located here `output/bazel`

Then once bazel is built add it to your path and go in the TensorFlow directory.

1. Apply the following patch to update TensorFlow to be built on XC system.
`patch -p1 < FixTensorFlowToBuild.path`

2. configure TensorFlow as explained [here](https://www.tensorflow.org/versions/master/get_started/os_setup.html#installing-from-sources) using the cuda option.

3. Start the build as follow:
`bazel build -c opt --config=cuda --verbose_failures --spawn_strategy=standalone //tensorflow/cc:tutorials_example_trainer`

If it succeed you will have the binary `tutorials_example_trainer` in `bazel-bin/tensorflow/cc/`.

The main issue with Bazel/TensorFlow build mechanism is that it clears the environment before launching a command and it does not provide anyway to setup the cleared environment.
That results in many hacks.
