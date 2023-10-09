# Lab Exercise 01 - Preliminaries

## Introduction and getting used to the duckiebots

Each table in the lab has one Duckiebot (DB) assigned to it. To get used to the bot, you should start it by pressing the battery button on the side and wait for it to boot up. This process takes roughly 1-2 minutes, and the small screen on the Duckiebot will indicate the battery state of charge (SOC), Wi-Fi connectivity, temperature, and more.

After the Duckiebot has started, check if there is a Wi-Fi connection and ensure that the battery is sufficiently charged:
- Verify that the Wi-Fi sign shows up.
- Test connectivity by pinging the bot `ping local.[botname]` ([botname] is also often refered as <Robot_Name>, [NAME-DUCKIEBOT], etc., in our case, the names are: einstein, andrew, tesla, oppenheimer, planck)
- Ensure that the Battery SOC is above 60%.

- [ ] Once you've confirmed these preliminaries, access the Duckiebot's dashboard through your web browser. Type `http://[botname].local/` into your browser's address bar and explore the Duckiebot dashboard. Start with the following tabs:
- "Info" - Provides an overview of information about the Duckiebot.
- "Mission Control" - Displays the camera image from your Duckiebot and offers control over three different speeds.
- "Health" - Provides a detailed current status of the bot.
- "Architecture" - Shows all ROS nodes and topics in use.
- "Components" - Lists the components that make up the Duckiebot.
- [ ] "Calibration" - Offers access to the calibration files for the camera and steering adjustments discussed earlier.
- "Settings" - Allows for changes to robot settings and permissions; please avoid making changes unless necessary.

## Connect with the Duckiebot
- [ ] Now let's connect to the Duckietown account by using the login on the left page and via the token:
```bash
dt1-3nT7FDbT7NLPrXykNJW6pALtoj6fpYzv3jrVkXx83Zesrip-43dzqWFnWd8KBa1yev1g3UKnzVxZkkTbfWMUqx9kXEP4RMmfsTY4hSd7G6s5Fa53dp
```
- [ ] Also, use the file manager to locate the configuration files again.
- [ ] As a third option to view those files and to show you that the bot can be connected in multiple ways, use SSH.
- For SSH:
- Open a Terminal.
- Insert `ssh duckie@[botname].local`.
- Use the password `quackquack`.
- Navigate to the directory calibrations via `cd /data/config/calibrations`.
- View the calibration files with `less [filename]`.
- In each of the three folders, representing the intrinsic, extrinsic, and kinematic calibration, there should be a `.YAML` file with a default name and with your `[botname].yaml`, which means that your Duckiebot has been calibrated.

## Accessing the DB
Now after we started the bot, checked if it is calibrated, and accessed the bot via multiple ways, we will try to control it with keyboard input and view the camera image.

### DB in your network
To control your DB, you first should check with your terminal if you see your DB.
```bash
dts fleet discover
```
This command should show all the accessible duckiebots in the lab which are connected with the same WIFI. They should also show the status "Ready". You can stop the scanning process via "CTRL+C", if not interrupted, it will repeatedly scan the network for duckiebots.
- [ ] Check if you see all / your DB

### Control the DB with your keyboard
**Preliminary:** Place it on the ground.
To control your Duckiebot, you can now use the terminal command:
```bash
dts duckiebot keyboard_control [botname]
```
Wait a few seconds until the PC and Duckiebot are connected. Meanwhile, open the dashboard in the browser again. While driving, you can view the acceleration and camera image in the `Mission Control` tab. You can stop the keyboard control via "CTRL+C" or by closing the controller window.
- [ ] Check if you could can control your DB

### Access Camera ROS stream
To get access to the cameras and the processed image, you first need to start a container with the GUI tools to then access the image view. Open an additional terminal (or terminal tab) for that. To start the container, call
```bash
dts start_gui_tools [botname]
```
afterwards, access the image view with
```bash
rqt_image_view
```
You can now choose between different visualisations, from compressed original image to edge detection and birds-eye-view (ground_projection_image)
- [ ] Check if you could see different camera streams of the DB and know what they are used for

### Lane Following
**Preliminary**: Place it on the ground.
To get the bot to follow the lane with a preinstalled demo, you first need to start the demo via 
``` Terminal
dts duckiebot demo --demo_name lane_following --duckiebot_name ![DUCKIEBOT_NAME] --package_name duckietown_demos
```
Next, for driving autonomously enable the keyboard control as above
``` Terminal
dts duckiebot keyboard_control ![DUCKIEBOT_NAME]
```
Wait a few seconds until the PC and Duckiebot are connected. Meanwhile, open the dashboard in the browser again. While driving, you can view the acceleration and camera image in the `Mission Control` tab.
When the DB can be controlled via the keyboard, use the buttons `a` and `s` to start and stop lane following, respectively.
- [ ] Check if your DB drives autonomously

# Lab Exercise 01 - Exercise

The following steps will walk you through the process of accessing the camera of the DB with ROS, while creating your own subscriber-publisher environment. 

- [ ] First, clone the repository onto your local machine using 
```bash
git clone https://github.com/intelligent-vehicles/lab-01-public.git
```
- [ ] and switch into the directory
```bash
cd lab-01-public
```
Now create a new branch, named `development-[botname]`, this ensures that you can work in your own environment and push onto your own branch, and each group can work in parallel.

- [ ] Create a new branch with
``` Terminal
git branch development-[botname]
```
- [ ] Switch to the new branch with
``` Terminal
git checkout development-[botname]
```
Alternatively, you can also do both steps in one command:
``` Terminal
git checkout -b development-[botname]
```
where `-b` is the `branch` flag, indicating that git will create a new branch and switch to it in one step.

- [ ] **Important**: check if you are on your branch, so further commits dont interfere with the main (in older versions, the main branch is often refered to as master branch) branch, using
``` Terminal
git branch
```

## New ROS DTProject
Next up, we have to edit the placeholders in the file `Dockerfile`
```text
ARG REPO_NAME="<REPO_NAME_HERE>"
ARG DESCRIPTION="<DESCRIPTION_HERE>"
ARG MAINTAINER="<YOUR_FULL_NAME> (<YOUR_EMAIL_ADDRESS>)"
```
- the name of the repository (e.g., my-ros-project, my-project, etc.);
- a brief description of the functionalities implemented in this project (e.g., IVLab-01);
- your name and email address to claim the role of maintainer (one person per group);
Apply the changes using a text editor, such as gedit or nano. You may want to try both to understand the differences between them.

For gedit
``` Terminal
gedit Dockerfile
```
For nano
``` Terminal
nano Dockerfile
```
- [ ] Check if you made and saved the changes

### Build the Project
Move to the project root and run the following command to build your docker image
```bash
dts devel build -f
```
The output should create a line of the following type: 
```bash
Final image name: duckietown/my-ros-project:v2-amd64
```
- [ ] Check if your output created a line similar to the one above

### Run the Project
We can now run the project with
```bash
dts devel run
```
The output should create lines looking like the following:
```bash
==> Launching app...
This is an empty launch script. Update it to launch your application.
<== App terminated!
```
For now, this only states a message from a standard launch file, that we will configure shortly. 
- [ ] Check if your output created lines similar to the lines above
First steps are done! :) 

### Checkpoint 0
- [ ] Commit the changes onto **your branch**. Use the following commit message. Describe what you did in `<Describing text>`.
``` Terminal
Checkpoint 0 - Cloning, Branching, Editing

<Describing text>
<Describing text>
<Describing text>
<Describing text>
<Describing text>

<Describing text>
<Describing text>
<Describing text>
<Describing text>
<Describing text>
```
Please provide detailed information in `<Describing text>` to demonstrate your understanding of the chapter, answer the questions, describe what you did for the checkpoints. Ensure that your description doesn't exceed  **2 blocks 5 lines, with each line having less than 72 characters**. 
**Important**: Each of you should understand what you have done in the previous chapter. Use the checkpoints to document a common understanding in your Group. 

## Catkin Packages
ROS utilizes the catkin build system to manage and construct its software within catkin workspaces, which are directories housing multiple software modules known as catkin packages. These packages can contain ROS nodes, which are sets of executables (such as binaries and script files). ROS nodes communicate through common patterns: publish-subscribe and request-reply, facilitated by ROS Publishers, ROS Subscribers, and ROS Services.

### Catkin workspace
In each catkin workspace, you find a folder named `packages`. We now create this folder with the following bash-command:
``` Terminal
mkdir -p ./packages/my_package
```
Where mkdir creates a directory, -p forces to also create necessary parent directories. 

A Catkin package, also known as a ROS package, is essentially a directory that includes two essential files: `package.xml` and `CMakeLists.txt`. To convert the `my_package` folder into a ROS package, you should create these two files inside the `my_package` directory. Change directory into `my_package`
``` Terminal
cd packages/my_package
```

#### Create package.xml
- [ ] First, create the `package.xml` inside the `my_package` directory with a text editor
``` Terminal
gedit package.xml
```
- [ ] insert the following code
``` Terminal
<package>
  <name>my_package</name>
  <version>0.0.1</version>
  <description>
  My first Catkin package in Duckietown.
  </description>
  <maintainer email="YOUR_EMAIL@EXAMPLE.COM">YOUR_FULL_NAME</maintainer>
  <license>None</license>

  <buildtool_depend>catkin</buildtool_depend>
</package>
```
- [ ] and replace the placeholders `YOUR_EMAIL@EXAMPLE.COM` and `YOUR_FULL_NAME`.

#### Create CMakeLists.txt
- [ ] Now create the file `CMakeLists.txt`, inserting the following code into the file
``` Terminal
cmake_minimum_required(VERSION 2.8.3)
project(my_package)

find_package(catkin REQUIRED COMPONENTS
  rospy
)

catkin_package()
```

### Checkpoint i
We now have a catkin package inside of a catkin workspace.

- [ ] Commit the changes onto **your branch**. Use the following commit message. Describe what you did in `<Describing text>`.
``` Terminal
Checkpoint i - Init Catkin Workspace

<Describing text>
<Describing text>
<Describing text>
<Describing text>
<Describing text>

<Describing text>
<Describing text>
<Describing text>
<Describing text>
<Describing text>
```
Please provide detailed information in `<Describing text>` to demonstrate your understanding of the chapter, answer the questions, describe what you did for the checkpoints. Ensure that your description doesn't exceed  **2 blocks 5 lines, with each line having less than 72 characters**. 
**Important**: Each of you should understand what you have done in the previous chapter. Use the checkpoints to document a common understanding in your Group. 

## ROS Publisher
The predominant communication pattern in robotics is the publish-subscribe pattern. In ROS, this pattern is implemented through ROS Publishers and ROS Subscribers. This section focuses on creating a ROS Publisher.

The underlying idea is straightforward: a publisher is responsible for sending messages from a ROS node into the ROS network, where they can be received by other nodes through ROS Subscribers, which will be created in later steps.

### Create a Publisher ROS Node
We'll demonstrate creating a simple ROS program using Python, although any ROS-supported language can be used. As we've learned in the "Create a new Catkin package" section, we'll populate our package with a ROS node that hosts a ROS Publisher.

Nodes are typically located within the `src/` directory of a Catkin package. To proceed, let's create the `src/` directory within `my_package`. 
- [ ] Execute the following command from the root of our DTProject:
``` Terminal
mkdir -p ./packages/my_package/src
```

- [ ] Next, we'll create the `my_publisher_node.py` file inside the `src/` directory we just established (hint: gedit). Place the following code inside it:
``` python
#!/usr/bin/env python3

import os
import rospy
from std_msgs.msg import String
from duckietown.dtros import DTROS, NodeType


class MyPublisherNode(DTROS):
    def __init__(self, node_name):
        # initialize the DTROS parent class
        super(MyPublisherNode, self).__init__(node_name=node_name, node_type=NodeType.GENERIC)
        # static parameters
        self._vehicle_name = os.environ['VEHICLE_NAME']
        # construct publisher
		#### 1 ####

    def run(self):
        # publish message every 1 second (1 Hz)
        rate = rospy.Rate(1)
        message = f"Hello from {self._vehicle_name}!"
        while not rospy.is_shutdown():
            rospy.loginfo("Publishing message: '%s'" % message)
			#### 2 ####
            rate.sleep()

if __name__ == '__main__':
    # create the node
    node = MyPublisherNode(node_name='my_publisher_node')
    # run node
    node.run()
    # keep the process from terminating
    rospy.spin()
```
- [ ] Placeholder 1 in line 16: Define a `rospy.Publisher`  which publishes `"chatter"` as a string with a queue-size of 10.
- [ ] Placeholder 2 in line 24: Publish the `message` defined in line 21 via a publish method on your `rospy.Publisher`.
- [ ] And change the file permissions of `my_publisher_node.py` to be executable, by either running 
``` Terminal
chmod +x ./packages/my_package/src/my_publisher_node.py
```
or 
``` Terminal
chmod 777 ./packages/my_package/src/my_publisher_node.py
```

### Create and Define a Launcher
In Duckietown, everything runs in Docker containers. Each DTProject compiles into a single Docker image, but we can declare multiple start behaviors for the same project/image using launchers. 
- [ ] To create a new launcher for a ROS publisher node, we create the file `my-publisher.sh` with the following content in the `.launchers` directory:
``` shell
#!/bin/bash

source /environment.sh

# initialize launch file
dt-launchfile-init

# launch publisher
rosrun my_package my_publisher_node.py

# wait for app to end
dt-launchfile-join
```

### Launch the Publisher Node
- [ ] First, check if the bot is still running by pinging it.
- [ ] Next re-compile the project, . (care of placeholders).
``` Terminal
dts devel build -H ROBOT_NAME -f
```
- [ ] And run the project by using the created launcher. 
``` Terminal
dts devel run -H ROBOT_NAME -L my-publisher
```
and every time you made changes, recompile and run the project again.

### Checkpoint ii
- [ ] If everything was done successfully, the terminal will publish a text, such as `hello from [botname]`
``` Terminal
[INFO] [<timestamp>]: Publishing message: 'Hello from [botname]!'
```

Summary: We now created 
- a publisher node `my-publisher-node.py`, 
- a launch file `my-publisher.sh`, 
- then built the project with `dts devel build ...`, 
- and ran the project through the launcher, pubilshing messages

- [ ] Commit the changes onto **your branch**. Use the following commit message. Describe what you did in `<Describing text>`.
``` Terminal
Checkpoint ii - ROS Publisher

<Describing text>
<Describing text>
<Describing text>
<Describing text>
<Describing text>

<Describing text>
<Describing text>
<Describing text>
<Describing text>
<Describing text>
```
Please provide detailed information in `<Describing text>` to demonstrate your understanding of the chapter, answer the questions, describe what you did for the checkpoints. Ensure that your description doesn't exceed  **2 blocks 5 lines, with each line having less than 72 characters**. 
**Important**: Each of you should understand what you have done in the previous chapter. Use the checkpoints to document a common understanding in your Group. 
## ROS Subscriber
In the field of robotics, the most prevalent communication pattern is the publish-subscribe pattern. ROS (Robot Operating System) utilizes this pattern through ROS Publishers and ROS Subscribers. In this section, we'll explore how to create a ROS Subscriber.

The fundamental idea is straightforward: a ROS Subscriber's role is to actively listen for messages related to a specific topic. These messages are published by other ROS nodes using ROS Publishers, and they travel over a ROS network. Subscribers play a crucial role in receiving and processing data from other parts of the robotic system, enabling seamless communication and coordination among different components

### Create a Subscriber ROS Node
We will now add a ROS node hosting a ROS subscriber - the counterpart of the publisher we just created. All ROS nodes need to be in the folder `/src`!
- [ ] Create a subscriber node named `my_subscriber_node.py` in the `/src` directory.
``` python
#!/usr/bin/env python3

import rospy
from duckietown.dtros import DTROS, NodeType
from std_msgs.msg import String

class MySubscriberNode(DTROS):

    def __init__(self, node_name):
        # initialize the DTROS parent class
        super(MySubscriberNode, self).__init__(node_name=node_name, node_type=NodeType.GENERIC)
        # construct subscriber
		#### 1 ####

    def callback(self, data):
        rospy.loginfo("I heard '%s'", data.data)

if __name__ == '__main__':
    # create the node
    node = MySubscriberNode(node_name='my_subscriber_node')
    # keep spinning
    rospy.spin()
```
- [ ] Placeholder 1 line 13: define a `rospy.Subscriber` as `self.sub` which subscribes to `"chatter"`, String, `self.callback` 
- [ ] Change the file permissions to executable.
### Create and Define a Launcher
- [ ] Create a Launcher file named `my-subscriber.sh` in the `./launchers` directory
``` shell
#!/bin/bash

source /environment.sh

# initialize launch file
dt-launchfile-init

# launch subscriber
rosrun my_package my_subscriber_node.py

# wait for app to end
dt-launchfile-join
```

### Launch the Subscriber Node
Open a new Terminal.
- [ ] Again, start with checking if the bot is still running by pinging it.
- [ ] Next re-compile the project (care of placeholders)
``` Terminal
dts devel build -H ROBOT_NAME -f
```
- [ ] And run the project by using the created launcher for the **subscriber**
``` Terminal
dts devel run -H ROBOT_NAME -L my-subscriber
```

Think about what was done in this subchapter and try to understand the console output... 

What could be the reason for aborting?

### Checkpoint iii
- [ ] Find a solution to the error message and what's missing

Summary: We now created 
- a publisher node `my-publisher-node.py`, 
- a launch file for the publisher node `my-publisher.sh`, 
- a subscriber node `my-subscriber-node.py`
- a launch file for the subscriber node `my-subscriber.sh`
- then built the project with `dts devel build ...`, 
- and ran the publisher, then the subscriber, to create our first ROS network that communicates between nodes

- [ ] Commit the changes onto **your branch**. Use the following commit message. Describe what you did in `<Describing text>`.
``` Terminal
Checkpoint iii - ROS Subscriber

<Describing text>
<Describing text>
<Describing text>
<Describing text>
<Describing text>

<Describing text>
<Describing text>
<Describing text>
<Describing text>
<Describing text>
```
Please provide detailed information in `<Describing text>` to demonstrate your understanding of the chapter, answer the questions, describe what you did for the checkpoints. Ensure that your description doesn't exceed  **2 blocks 5 lines, with each line having less than 72 characters**. 
**Important**: Each of you should understand what you have done in the previous chapter. Use the checkpoints to document a common understanding in your Group. 
## ROS Subscriber for Camera Stream
We will now set a subscriber for the published camera stream of the DB. Normally, we would have to create a new Catkin package. But in this case, we already created that by defining `packages/my_package`, the catkin workspace files `package.xml` and `CMakeLists.txt`. We will use this basic workspace for the follwing steps. 

### Create Camera Subscriber Node
- [ ] First, we will create a camera node `camera_reader_node.py` in the `/src` directory. 
``` python
#!/usr/bin/env python3

import os
import rospy
from duckietown.dtros import DTROS, NodeType
from sensor_msgs.msg import CompressedImage

import cv2
from cv_bridge import CvBridge

class CameraReaderNode(DTROS):

    def __init__(self, node_name):
        # initialize the DTROS parent class
        super(CameraReaderNode, self).__init__(node_name=node_name, node_type=NodeType.VISUALIZATION)
        # static parameters
        self._vehicle_name = os.environ['VEHICLE_NAME']
		#### 1 ####
        # bridge between OpenCV and ROS
        self._bridge = CvBridge()
        # create window
        self._window = "camera-reader"
        cv2.namedWindow(self._window, cv2.WINDOW_AUTOSIZE)
        # construct subscriber
		#### 2 ####

	def callback(self, msg):
        # convert JPEG bytes to CV image
		#### 3 ####
        # display frame
		#### 4 ####
        cv2.waitKey(1)

if __name__ == '__main__':
    # create the node
    node = CameraReaderNode(node_name='camera_reader_node')
    # keep spinning
    rospy.spin()
```
The file holds a few placeholders. Fill the blank spaces `<...>` in the file in...
- [ ] Placeholder 1 line 18: Define `self._camera_topic` as a raw string of the compressed image node of your regarding vehicle
- [ ] Placeholder 2 line 25: Define `self.sub`, a `rospy.Subscriber` which is subscribed to the previously define `self._camera_topic` via the self.callback function and subscribing to `CompressedImage`.
- [ ] Placeholder 3, line 29: Define `image`, which converts a CompressedImage message recieived via ROS into a OpenCV image format, subsequently allowing further image processing and analysis
- [ ] Placeholder 4, line 31: Show the image via cv2 
- [ ] Also, make the file executable

### Create and Define Camera Launcher
- [ ] Create a launcher file named `camera-reader.sh` in the `/launchers` directory with the following content
``` shell
#!/bin/bash

source /environment.sh

# initialize launch file
dt-launchfile-init

# launch subscriber
rosrun <catking-workspace-directory> <python-camera-node>

# wait for app to end
dt-launchfile-join
```
- [ ] Fill the placeholder line (line 9) in this launch file

- [ ] Lastly, compile the project
``` Terminal
dts devel build -f
```
- [ ] And launch the node
``` Terminal
dts devel run -R ROBOT_NAME -L camera-reader -X
```
A window with the camera stream of the DB should pop up on your pc.
### Checkpoint iv
- [ ] Commit the changes onto **your branch**. Use the following commit message. Describe what you did in `<Describing text>`.
``` Terminal
Checkpoint iv - ROS Camera Subscriber

<Describing text>
<Describing text>
<Describing text>
<Describing text>
<Describing text>

<Describing text>
<Describing text>
<Describing text>
<Describing text>
<Describing text>
```
Please provide detailed information in `<Describing text>` to demonstrate your understanding of the chapter, answer the questions, describe what you did for the checkpoints. Ensure that your description doesn't exceed  **2 blocks 5 lines, with each line having less than 72 characters**. 
**Important**: Each of you should understand what you have done in the previous chapter. Use the checkpoints to document a common understanding in your Group. 

- [ ] Check your directory with the command `tree` in the console to view the contents of your directory and check if all the previously created files exit 
	- [ ] two files for the catkind workspace
	- [ ] three launcher files
	- [ ] three node files

## Add an edge detector
Finally, we will enhance the functionality of the most recently created camera subscriber node. Instead of displaying just one image from the compressed camera stream, we will extend it to process the camera stream. This modification involves editing the callback method in the previously created file. Additionally, we will introduce a grayscale image as an intermediate step and include an edge detection image named "Canny" in the process.
- [ ] Apply the code necessary to the placeholders below
``` python
### New callback method
	def callback(self, msg):
        # convert JPEG bytes to CV image
		#### 1 ####
        # convert the image to a gray-scale image
		#### 2 ####
        # convert the gray-scale image into a Canny (edge detector)
		#### 3 ####
        # Use the cv2.imshow method to create a window of the three different images
		#### 4 ####
		#### 5 ####
		#### 6 ####
        cv2.waitKey(1)
```
- [ ] Placeholder 1, line 4: Define `image`, which converts a CompressedImage message recieived via ROS into a OpenCV image format, subsequently allowing further image processing and analysis
- [ ] Placeholder 2, line 6: Define `gray`, converting OpenCV image format into grayscale, subsequently allowing further image processing and analysis
- [ ] Placeholder 3, line 8: Define `gray`, converting OpenCV image format into grayscale, subsequently allowing further image processing and analysis
- [ ] Placeholder 4, 5, 6: Show the different views as an output
### Checkpoint v

- [ ] Commit the changes onto **your branch**. Use the following commit message. Describe what you did in `<Describing text>`.
``` Terminal
Checkpoint v - Edge Detection

<Describing text>
<Describing text>
<Describing text>
<Describing text>
<Describing text>

<Describing text>
<Describing text>
<Describing text>
<Describing text>
<Describing text>
```
Please provide detailed information in `<Describing text>` to demonstrate your understanding of the chapter, answer the questions, describe what you did for the checkpoints. Ensure that your description doesn't exceed  **2 blocks 5 lines, with each line having less than 72 characters**. 
**Important**: Each of you should understand what you have done in the previous chapter. Use the checkpoints to document a common understanding in your Group. 

This is it! you are done! you have now created your first ros workspace, accessed the camera, created an edge detector. Congratulations! 
- [ ] Here is another checkbox for satisfactory reasons ;)

# Final Words
After everything is up and running, you can inspect and compare the outcomes of your edge detector with those generated by the DB's original edge detector, as detailed in the "Access Camera ROS Stream" section.

In the next lab, you will apply the fundamentals learned today to configure an object detector on the DB. But for now, congratulations on completing the first exercise! Feel free to experiment with the robots, explore various possibilities, and contemplate how this small-scale scenario can serve as a foundation for real-world tasks.
