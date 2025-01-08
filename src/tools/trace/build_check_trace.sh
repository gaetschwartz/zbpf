#!/bin/bash
set -e

zig build trace \
  -Dsyscall=unlinkat:arg1,ret \
  -Dkprobe=do_unlinkat:arg0,arg1,arg1.name,ret \
  -Dkprobe=do_rmdir:arg0,ret,stack \
  -Duprobe=/proc/self/exe[testing_call+0]:arg0,arg1,ret,stack

sudo ./zig-out/bin/trace --timeout 2 --testing
