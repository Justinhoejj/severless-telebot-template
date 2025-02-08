#!/bin/bash

# Define output directory
mkdir -p $OUTPUT_DIR

# Clean the output directory before installing dependencies
rm -rf $OUTPUT_DIR/*

# Install dependencies inside OUTPUT_DIR with the correct platform settings
pip3 install \
    --platform manylinux2014_x86_64 \
    --implementation cp \
    --python-version 3.11 \
    --only-binary=:all: \
    --target $OUTPUT_DIR \
    --upgrade \
    --force-reinstall \
    -r $REQUIREMENTS_FILE
