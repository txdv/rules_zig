#!/bin/bash

export HOME=/tmp/zig-cache/
export ZIG_LOCAL_CACHE_DIR="$HOME"
export ZIG_GLOBAL_CACHE_DIR=$ZIG_LOCAL_CACHE_DIR

external/zig_sdk/zig $@
