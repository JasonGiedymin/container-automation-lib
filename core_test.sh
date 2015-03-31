#!/bin/bash

source ./core.sh

function TestRunCmd() {
  local list=("Joe" "Bob" "Dan")
  local result=`runCmd "echo" "${list[@]}"`

  local expected="Joe
Bob
Dan
[echo] exited successfully."

  echo "--> [TestRunCmd]"
  if [ "$result" != "$expected" ]; then
    echo "  fail"
    echo "    TestRunCmd failed with result: $result"
    return 0;
  else
    echo "  pass"
    return 0;
  fi;
}

function TestRunCmdArgs() {
  local list=("Joe" "Bob" "Dan")
  local result=`runCmd "echo -n" "${list[@]}"`
  local expected="JoeBobDan[echo -n] exited successfully."

  if [ "$result" != "$expected" ]; then
    echo "  fail"
    echo "    TestRunCmdArgs failed with result: $result"
    return 0;
  else
    echo "  pass"
    return 0;
  fi;
}

init() {
  TestRunCmd
  local rc=$?

  if [ $rc -gt 0 ]; then
    echo "Init test failed. This is required to work."
    exit 1;
  fi;
}

tests() {
  local testFuncs=(TestRunCmdArgs)
  run "${testFuncs[@]}"
}

main() {
  init
  tests
}

main