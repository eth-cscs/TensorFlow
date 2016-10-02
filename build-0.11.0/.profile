module load java/jdk1.8.0_51
module load gcc/4.9.2
module load cudatoolkit/7.0.28-1.0502.10742.5.1
module load Python/3.5.1-CrayGNU-2016.03
module load git/2.6.0

export LD_LIBRARY_PATH="/scratch/daint/lhelming/tools/cuda/lib64:$LD_LIBRARY_PATH"
export PATH=/scratch/daint/lhelming/usr/local/bin:/scratch/daint/lhelming/usr/local/share/swig/3.0.10/:/scratch/daint/lhelming/tools/jdk1.8/bin:/scratch/daint/lhelming/tools/bazel/output/:$PATH
#export JAVA_HOME=/scratch/daint/lhelming/tools/jdk1.8

export BLAS=/opt/intel/15.0.1.133/composer_xe_2015.1.133/mkl/lib/intel64/libmkl_blas95_ilp64.a
export LAPACK=/opt/intel/15.0.1.133/composer_xe_2015.1.133/mkl/lib/intel64/libmkl_lapack95_ilp64.a

export SWIG_PATH=/scratch/daint/lhelming/usr/local/bin/swig
export SWIG_LIB=/scratch/daint/lhelming/usr/local/share/swig/3.0.10