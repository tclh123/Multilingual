#!/bin/bash

here="$(cd "${0%/*}"; pwd)"
root="${here%/*}"

DIR_CODES="codes"
DIR_TESTS="tests"
DIR_TOOLS="tools"

failed_cnt=0
passed_cnt=0

test_lang() {
  echo "==========  Codes in ** $lang **  =========="
  echo

  topic=$1
  src=$2
  lang=$3

  idx=1
  while [[ -e $root/$DIR_TESTS/$topic/$idx.out ]]; do
    source "$root/$DIR_TOOLS/lang-$lang.sh" "$src" "$root/$DIR_TESTS/$topic/$idx.in" "$root/$DIR_TESTS/$topic/$idx.out"
    if [[ $? -ne 0 ]]; then
      let "failed_cnt += 1"
      echo "Test Case [$idx] FAILED! in $src"
      echo
    else
      let "passed_cnt += 1"
      echo "Test Case [$idx] PASSED! in $src"
      echo
    fi
    let "idx += 1"
  done
}


for dir_case in `find $root/$DIR_TESTS -type d -mindepth 1`; do
  topic=${dir_case##*/}
  echo "Run Tests in Topic {{ $topic }}"
  echo
  for dir_src in `find $root/$DIR_CODES -type d -mindepth 2`; do
    lang=${dir_src##*/}
    for src in `find $dir_src -type f`; do
      if [[ ${src##*/} == src.* ]]; then
        test_lang "$topic" "$src" "$lang"
      fi
    done
  done
done


echo "$passed_cnt PASSED, $failed_cnt FAILED!"
echo
