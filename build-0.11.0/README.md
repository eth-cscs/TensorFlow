cd /scratch/daint/$USER/

# clone tensorflow
git clone https://github.com/tensorflow/tensorflow.git

mkdir -p /scratch/daint/$USER/tools/
clone bazel (current master = 0.3.2)
git clone https://github.com/bazelbuild/bazel.git

# get swig
cd /scratch/daint/$USER/tools/
wget http://prdownloads.sourceforge.net/swig/swig-3.0.10.tar.gz
tar xvf swig-3.0.10.tar.gz
cd swig-3.0.10
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.39.tar.bz2
/scratch/daint/$USER/tools/swig-3.0.10/Tools/pcre-build.sh 

mkdir -p /scratch/daint/$USER/tools/usr/local/
./configure --prefix=/scratch/daint/$USER/tools/usr/local/

make
make install

# set env variables in ~/.profile
export SWIG_PATH=/scratch/daint/lhelming/usr/local/bin/swig
export SWIG_LIB=/scratch/daint/lhelming/usr/local/share/swig/3.0.10

source ~/.profile

# modify in bazel dir:
	modified:   scripts/bootstrap/compile.sh
	modified:   tools/cpp/CROSSTOOL

# modify in tensorflow dir:
	modified:   third_party/gpus/crosstool/CROSSTOOL.tpl
	modified:   third_party/gpus/crosstool/clang/bin/crosstool_wrapper_driver_is_not_gcc.tpl


cd /scratch/daint/$USER/tools/bazel/
/scratch/daint/$USER/tools/bazel/compile

cd /scratch/daint/$USER/tensorflow/
./configure < config.in

bazel build -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package --verbose_failures


