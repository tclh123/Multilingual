#!/bin/bash

RET_CODE=0

src=$1
f_in=$2
f_out=$3
bin_dir=${1%/*}
f_out_tmp=$bin_dir/out

python $src < $f_in > $f_out_tmp
diff $f_out $f_out_tmp

if [[ $? -ne 0 ]]; then
  RET_CODE=1
fi

rm $f_out_tmp
find $bin_dir -name "*.pyc" -exec rm {} +

return $RET_CODE
