#!/bin/bash

RET_CODE=0
CC=g++

src=$1
f_in=$2
f_out=$3
bin_dir=${1%/*}
bin=$bin_dir/main
f_out_tmp=$bin_dir/out

${CC} $src -o $bin && $bin<$f_in>$f_out_tmp
diff $f_out $f_out_tmp

if [[ $? -ne 0 ]]; then
  RET_CODE=1
fi

rm $bin $f_out_tmp

return $RET_CODE
