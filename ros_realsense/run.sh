#!/bin/sh

# Define X11 and shared folder variables
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.X11-unix
SHARED_DIR=/catkin_ws
HOST_DIR=$(pwd)/catkin_ws
IMAGE_NAME="ros_noetic_realsense"
CONTAINER_NAME="realsense_ros"

# Allow access to the X server
xhost +

# Output message showing the mount folder
echo -e "\e[32mMounting folder:
    $HOST_DIR    to
    $SHARED_DIR\e[0m"

# Build the Docker image
echo "Building the Docker image..."
docker build -t $IMAGE_NAME .

# Check if a container with the same name is already running
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing the existing container..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Run the Docker container
echo "Running the Docker container..."
docker run \
    -it \
    --volume=$XSOCK:$XSOCK:rw \
    --volume=$XAUTH:$XAUTH:rw \
    --volume=$HOST_DIR:$SHARED_DIR:rw \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY=${DISPLAY}" \
    --privileged -v /dev/bus/usb:/dev/bus/usb \
    --net=host \
    --name $CONTAINER_NAME \
    $IMAGE_NAME bash

# Disable access to the X server after container runs
xhost -
