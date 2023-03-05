#!/bin/bash
wget -O q-queue-latest.tar.gz https://github.com/justincampbell/q-queue/archive/latest.tar.gz q-queue
tar -zxvf q-queue-latest.tar.gz
cd q-queue-latest/
make install
