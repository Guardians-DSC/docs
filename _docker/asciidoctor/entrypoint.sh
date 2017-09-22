#!/bin/bash

cd /docs
asciibinder clean && asciibinder build
nohup guard >/guard.log 2>&1 &
tail -f /guard.log
