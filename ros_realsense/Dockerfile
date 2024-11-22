# Base image: ROS Noetic
FROM ros:noetic-ros-base

# Update the system and install dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-catkin-tools \
    git \
    ros-noetic-rviz \
    ros-noetic-roslaunch \
    tmux \
    nano \
    libusb-1.0-0 \
    ros-noetic-cv-bridge \
    ros-noetic-realsense2-camera \
    && rm -rf /var/lib/apt/lists/*

# Install pyrealsense2
RUN pip3 install --upgrade pip \
    && pip3 install pyrealsense2

# Create a catkin workspace
RUN mkdir -p /catkin_ws/src
WORKDIR /catkin_ws

# Build the workspace
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc

# Set working directory to catkin_ws
WORKDIR /catkin_ws

# Default command
CMD ["bash"]
