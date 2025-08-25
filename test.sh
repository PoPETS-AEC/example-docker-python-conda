#!/bin/bash

## rather than using conda activate, specify which virtual env to run into, 
## passing flag to also stream stdout and stderr
conda run --no-capture-output -n myenv python3 main.py
