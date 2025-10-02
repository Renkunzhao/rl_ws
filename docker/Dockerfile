ARG ISAACLAB_ROS2_IMAGE_ARG

# we use the basic isaaclab image as the base
FROM ${ISAACLAB_ROS2_IMAGE_ARG} AS base

ARG DOCKER_RL_WS_PATH_ARG
ENV DOCKER_RL_WS_PATH=${DOCKER_RL_WS_PATH_ARG}

USER root

# make working directory as the Isaac Lab directory
# this is the default directory when the container is run
WORKDIR /workspace/
