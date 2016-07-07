## Tensorflow

###  v0.9.0 (*new*)

* GPU-enabled TF on XC30
  * [Running existing module](https://github.com/eth-cscs/TensorFlow/wiki/tensorflow-0.9.0-daint)
  * [Building pip package](https://github.com/eth-cscs/TensorFlow/wiki/TensorFlow-0.9.0-Daint-GPU-build)

### v0.6.0

The first step is to build Tensorflow which is not trivial on XC system.
Tensorflow uses Bazel as a build system which is in Beta version meaning that it requires a lot of tricks to have it working.
All necessary files to compile Tensorflows are in [build](https://github.com/eth-cscs/TensorFlow/tree/master/build)

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
- You will need to edit the file `tools/cpp/CROSSTOOL` to setup your GCC path, see end of file `FixBazelToBuild.patch` as an example

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

---

Building a pip package for Tensorflow:

1. Load the apropriate Python module that allows to create a `virtual env`, on Piz-Daint executes the following code:
`module load Python/2.7.10-CrayGNU-5.2.40`

2. Create a virual environement and install numpy:
```
virtualenv tf_venv
source tf_venc/bin/activate
pip install numpy
deactivate
```

3. Configure TensorFlow by specifying the Python binary in your virtual environmemt also add the Cuda location like in the normal build (aforementioned).

4. Compile it by following the steps [here](https://www.tensorflow.org/versions/master/get_started/os_setup.html#create-the-pip-package-and-install)

5. Create a new virtual env.
You will obtain a file named like `tensorflow-0.6.0-cp27-none-linux_x86_64.whl`, create a new virtual env and install this file with pip:
```
virtualenv-2.7 --system-site-packages --python=$( which python2.7 ) tftest_venc
source tftest_venc/bin/activate
pip install tensorflow-0.6.0-cp27-none-linux_x86_64.whl
pip install --upgrade numpy
```

6. Test it, run the following code while still being the tftest_venv:
```
cd tensorflow/models/image/mnist
aprun python convolutional.py
```

