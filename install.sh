#!/usr/bin/env bash

function ansible_run() {
  DIR=${PWD}
  echo ${DIR}
  TMP_DIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`

  cd ${TMP_DIR}
  git clone http://github.com/ansible/ansible.git ${TMP_DIR}/ansible

  export PATH=${TMP_DIR}/ansible/bin:${PATH}
  export ANSIBLE_LIBRARY=${TMP_DIR}/ansible/library
  export PYTHONPATH=${TMP_DIR}/ansible/lib:${PYTHONPATH}

  cd ${DIR}
  echo $(`which ansible-playbook`)
  ansible-playbook -i ${DIR}/inventory -vvvv ${DIR}/mac.yml

  rm -rf ${TMP_DIR}
}

ansible_run
