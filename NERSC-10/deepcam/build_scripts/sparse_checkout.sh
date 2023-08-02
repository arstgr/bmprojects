#!/bin/bash
#this script should run in the $N0_DEEPCAM directory.


Usage () {
    cat <<- EOF
sparse_checkout.sh:
About: clone the DeepCAM source code from a git repository.
  The repositories include a considerable volume of data that is not used by DeepCAM.
  A sparse checkout will retrieve only the DeepCAM source code.
  Either of two implementations may be cloned, the baseline implementation,
  or one that has been optimized for NERSC's Perlmutter system.
Usage: sparse_checkout.sh <implementation>
Allowed implementations: [ baseline, optimized_pm ]
EOF
}

parse_args () {

  #validate CL arguments
  #defines the global variables: impl

  #provide help if requested
  if [ $# -ge 1 ]; then
    if [ $1 == "--help" ]; then
      Usage
      exit
    fi
  fi

  #validate argc
  if [ $# -ne 1 ]; then
    echo "One arguments is required, but $# were provided."
    Usage
    exit 1
  fi

  impl=$1
  #validate impl
  case "$impl" in
  baseline);;
  optimized_pm);;
  *)
    echo "Error: the requested impl ($1) is not supported."
    Usage
    exit 1
  esac

#end parse_args()
}

checkout_baseline () {

  dest="baseline"
  if [[ -d $dest ]]; then
      echo "Destination directory ($dest) already exists; exiting."
      exit
  fi
  mkdir $dest
  pushd $dest

  url="https://github.com/NERSC/mlperf-hpc.git"
  git init
  git config core.sparseCheckout true
  git remote add -f origin $url 

  cat << EOF > .git/info/sparse-checkout
deepcam
EOF

  git checkout n10-deepcam
  ln -s deepcam/src/deepCam src_deepCam

  popd
}

checkout_optimized (){

  dest="optimized_pm"
  if [[ -d $dest ]]; then
      echo "Destination directory ($dest) already exists; exiting."
      exit
  fi
  mkdir $dest
  pushd $dest

  url="https://github.com/mlcommons/hpc_results_v1.0.git"
  git init
  git config core.sparseCheckout true
  git remote add -f origin $url 

  cat << EOF > .git/info/sparse-checkout
LBNL
EOF

  git checkout master
  ln -s LBNL/benchmarks/deepcam/implementations/deepcam-pytorch src_deepCam
  
  popd
}


__main__ () {

  #sets variables [ impl ]
  parse_args "$@" 

  case "$impl" in
  baseline)
    checkout_baseline
    ;;
  optimized_pm)
    checkout_optimized
    ;;
  esac

}

 __main__ "$@"
