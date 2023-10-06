# Lab Exercise 01 - Preliminaries

## Introduction and getting used to the duckiebots

Each table in the lab has one duckiebot (DB) assigned to it. To get used to the bot, you should start it with the battery button on the side and wait for it to start up (this needs roughly 1-2 minutes, the small screen on the duckiebot will indicate the battery SOC, WIFI connectivity, temperature, etc...)

After the DB has been started, check if there is a WIFI connectivity and if the battery is sufficiently charged. 
- WIFI sign showing up
- You can ping the bot via `ping local.[botname]` ([botname] is also often refered as <Robot_Name>, [NAME-DUCKIEBOT], etc.)
- Battery SOC above 60%

When the preliminaries are checked, go for the dashboard, which you can access via browser. Type in your searchbar `http://[botname].local/` and explore the duckiebot dashboard, e.g. starting with the tabs 
- "Info" - Overview information
- "Mission Control" - Should show the camera image of your duckiebot and 3 different speeds,
- "Health" - Showing the current status of the bot in more detail,
- "Architecture" - Shows the entire ros nodes and topics
- "Components" - Shows the components of what the duckie is built
- "Calibration" - Shows the files for camera and steering calibration we previously talked about
- "Settings" - Settings allow changing of robot settings and permissions, please leave untouched


Now lets connect to the duckietown account by using the login on the left page and via the token: 
```bash
dt1-3nT7FDbT7NLPrXykNJW6pALtoj6fpYzv3jrVkXx83Zesrip-43dzqWFnWd8KBa1yev1g3UKnzVxZkkTbfWMUqx9kXEP4RMmfsTY4hSd7G6s5Fa53dp
```
and use the file manager to locate the configuration files again.
As a third option to view those files and to show you that the bot can be connected in multiple ways, use ssh.
For ssh:
- Open a Terminal
- insert `ssh duckie@[botname].local`
- Use the password `quackquack`
- navigate to the directory calibrations via `cd /data/config/calibrations`
- view the calibration files with `less [filename]`
- In each of the three folders, representing the intrinsic, extrinsic, and kinematic calibration, there should be a `.YAML`-file with a default name and with your `[botname].yaml`, which means that your DB has been calibrated.

## Accessing the DB
Now after we started the bot, checked if it is calibrated, and accessed the bot via multiple ways, we will try to control it with keyboard input and view the camera image.

### DB in your network
To control your DB, you first should check with your terminal if you see your DB.
```bash
dts fleet discover
```
This command should show all the accessible duckiebots in the lab which are connected with the same WIFI. They should also show the status "Ready". You can stop the scanning process via "CTRL+C".

### Control the DB with your keyboard
Preliminary: Place it on the ground.
To control your DB, you can now use the terminal command 
```bash
dts duckiebot keyboard_control [botname]
```
Wait a few seconds until the PC and DB are connected. Meanwhile, open your dashboard again. While driving, you can view the acceleration and camera image. You can stop the keyboard control via "CTRL+C" or closing the controller window.

### Access Camera ROS stream
To get access to the cameras and the processed image, you first need to start a container with the gui tools to then acces the image-view.
Open an additional terminal (or terminal tab) for that.
To start the container, call
```bash
dts start_gui_tools [botname]
```
afterwards, access the image view with
```bash
rqt_image_view
```
You can now choose between different visualisations, from compressed original image to edge detection and birds-eye-view (ground_projection_image)

### Lane Following
Preliminary: Place it on the ground.
To get the bot to follow the lane with a preinstalled demo, you first need to start the demo via 
```bash
Demo command
```
And then go back into keyboard control as stated above. You can use "a" and "s" to start and stop the auto-driving pilot, called lane-following. 

# Lab Exercise 01 - Exercise


# Template: template-ros

This template provides a boilerplate repository
for developing ROS-based software in Duckietown.

**NOTE:** If you want to develop software that does not use
ROS, check out [this template](https://github.com/duckietown/template-basic).


# Lab

### 1. Fork this repository

Use the fork button in the top-right corner of the github page to fork this template repository.


### 2. Create a new repository

Create a new repository on github.com while
specifying the newly forked template repository as
a template for your new repository.


### 3. Define dependencies

List the dependencies in the files `dependencies-apt.txt` and
`dependencies-py3.txt` (apt packages and pip packages respectively).


### 4. Place your code

Place your code in the directory `/packages/` of
your new repository.


### 5. Setup launchers

The directory `/launchers` can contain as many launchers (launching scripts)
as you want. A default launcher called `default.sh` must always be present.

If you create an executable script (i.e., a file with a valid shebang statement)
a launcher will be created for it. For example, the script file 
`/launchers/my-launcher.sh` will be available inside the Docker image as the binary
`dt-launcher-my-launcher`.

When launching a new container, you can simply provide `dt-launcher-my-launcher` as
command.
