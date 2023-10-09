#!/bin/bash

source /environment.sh

# initialize launch file
dt-launchfile-init

# launch publisher
rosrun my_package my_publisher_node.py

# wait for app to end
dt-launchfile-join
