# Tensorflow
This document tries to give a quick introduction how to get a first test program running. Note that running TensorFlow at CSCS is still not officially supported and thus support is limited.

## Supported Systems
TensorFlow has only been tested on Piz Daint.

## Loading TensorFlow Module
As an example we use TensorFlow 0.11.0, for other versions have a look at the [Wiki](https://github.com/eth-cscs/TensorFlow/wiki).
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

### Test using the MNIST demo model
A more elaborate test is to actually train a model using the GPU:
```
salloc -N1 -C gpu
srun python -m 'tensorflow.models.image.mnist.convolutional'
```

The output should be something like this:
```
I tensorflow/stream_executor/dso_loader.cc:111] successfully opened CUDA library libcublas.so.8.0 locally
I tensorflow/stream_executor/dso_loader.cc:111] successfully opened CUDA library libcudnn.so.5 locally
I tensorflow/stream_executor/dso_loader.cc:111] successfully opened CUDA library libcufft.so.8.0 locally
I tensorflow/stream_executor/dso_loader.cc:111] successfully opened CUDA library libcuda.so.1 locally
I tensorflow/stream_executor/dso_loader.cc:111] successfully opened CUDA library libcurand.so.8.0 locally
I tensorflow/core/common_runtime/gpu/gpu_device.cc:951] Found device 0 with properties:
name: Tesla P100-PCIE-16GB
major: 6 minor: 0 memoryClockRate (GHz) 1.3285
pciBusID 0000:02:00.0
Total memory: 15.90GiB
Free memory: 15.62GiB
I tensorflow/core/common_runtime/gpu/gpu_device.cc:972] DMA: 0
I tensorflow/core/common_runtime/gpu/gpu_device.cc:982] 0:   Y
I tensorflow/core/common_runtime/gpu/gpu_device.cc:1041] Creating TensorFlow device (/gpu:0) -> (device: 0, name: Tesla P100-PCIE-16GB, pci bus id: 0000:02:00.0)
Extracting data/train-images-idx3-ubyte.gz
```

## Submit a Job to SLURM (Scheduling System)
More detailed documentation on how to submit a job can be found [here](http://user.cscs.ch/getting_started/running_jobs/piz_daint/index.html).

## Compile Custom Version of TensorFlow

