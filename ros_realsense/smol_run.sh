docker run \
    -it \
    --privileged -v /dev/bus/usb:/dev/bus/usb \
    --net=host \
    ros_noetic_realsense