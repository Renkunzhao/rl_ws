ARG ISAACLAB_ROS2_IMAGE_ARG

# we use the basic isaaclab image as the base
FROM ${ISAACLAB_ROS2_IMAGE_ARG} AS base

ARG DOCKER_RL_WS_PATH_ARG
ENV DOCKER_RL_WS_PATH=${DOCKER_RL_WS_PATH_ARG}

USER root

RUN apt update && \
    apt install -y jq && \
    # Unitree SDK2
    apt install -y libyaml-cpp-dev libboost-all-dev libeigen3-dev libspdlog-dev libfmt-dev && \
    # Mujoco 
    apt install -y libglfw3-dev libxinerama-dev libxcursor-dev libxi-dev && \
    # Unitree Mujoco 
    apt install -y joystick

# make working directory as the Isaac Lab directory
# this is the default directory when the container is run
WORKDIR /workspace/${DOCKER_RL_WS_PATH}
