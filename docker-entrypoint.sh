#!/bin/bash

cd /docs
asciibinder clean && asciibinder build
tail -f /dev/null
