# Tensorflow
Running TensorFlow of CSCS is still not officially supported and thus support is limited. This document tries to give you a quick introduction how to get a first test program running.

## Supported Systems
TensorFlow has only been tested on Piz Daint.

## Loading TensorFlow Module
Let's use TensorFlow 0.11.0. For other versions have a look at the [[Wiki][https://github.com/eth-cscs/TensorFlow/wiki]].
```
module load daint-gpu
module use /apps/daint/UES/6.0.UP02/sandbox-ds/easybuild/haswell/modules/all/
module load TensorFlow/0.11.0-CrayGNU-2016.11-Python-3.5
```

## Test TensorFlow

### Simple Import Test
On the Daint login node, directly try to import the TensorFlow module:

```
python -c 'import tensorflow as tf'
```

The output should be something like this:

```
I tensorflow/stream_executor/dso_loader.cc:111] successfully opened CUDA library libcublas.so.8.0 locally
I tensorflow/stream_executor/dso_loader.cc:111] successfully opened CUDA library libcudnn.so.5 locally
I tensorflow/stream_executor/dso_loader.cc:111] successfully opened CUDA library libcufft.so.8.0 locally
I tensorflow/stream_executor/dso_loader.cc:111] successfully opened CUDA library libcuda.so.1 locally
I tensorflow/stream_executor/dso_loader.cc:111] successfully opened CUDA library libc
```

### Submit a Test Program

## Submit a Job to SLURM (Scheduling System)
More detailed documentation on how to submit a job can be found [[here][http://user.cscs.ch/getting_started/running_jobs/piz_daint/index.html]].

## Compile Custom Version of TensorFlow

