#!/bin/bash

wget -O ~/.gdbinit-gef.py -q https://gef.blah.cat/py

echo source ~/.gdbinit-gef.py >> ~/.gdbinit
