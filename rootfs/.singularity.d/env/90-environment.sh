module() { eval `/usr/bin/modulecmd sh $*`; }
export MODULEPATH=/opt/bwhpc/ul/modulefiles:/opt/bwhpc/common/modulefiles
export PSM_SHAREDCONTEXTS_MAX=6 # do NOT allocate all HCs, leave remaining HCs for other MPI apps running simultaneously
export PS1="\[\033[01;32m\]\u@${SINGULARITY_CONTAINER}@\h\[\033[01;34m\] \w \$\[\033[00m\] "