FROM osrf/ros:jazzy-desktop-full

# ==================== CURRENT BUILDING USER IS ROOT ==================== #
# Define running arguments
ARG USERNAME=ros2jazzydevcontainer
ARG USER_ID=1001
ARG GROUPNAME=$USERNAME
ARG GROUP_ID=$USER_ID

# Create a non-root user, a hidden "config" directory, and configure its permission
RUN groupadd --gid $GROUP_ID $GROUPNAME \
    && useradd -s /bin/bash --uid $USER_ID --gid $GROUP_ID -m $USERNAME \
    && mkdir /home/$USERNAME/.config \
    && chown $USER_ID:$GROUP_ID /home/$USERNAME/.config

# Install sudo and configure passwordless sudo for the non-root user
RUN apt-get update \
    && apt-get install -y sudo \
    && rm -rf /var/lib/apt/lists/* \
    && echo "ros2jazzydevcontainer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install additional packages at build
RUN apt-get update \
    && apt-get install -y \
        python3-pip \
        python3-venv \
        python3-colcon-common-extensions \
        git \
        x11-apps \
        libxcb-xinerama0 \
        libxcb-xinput0 \
    && rm -rf /var/lib/apt/lists/*

# Change current user to $USERNAME
USER $USERNAME

# ==================== CURRENT BUILDING USER IS NOW $USERNAME ==================== #
# Set up !and change! container's current working directory to workspace
WORKDIR /workspace

# Overwrite default .bashrc with ours (see docker-compose context to understand path)
COPY .devcontainer/.bashrc /home/$USERNAME/.bashrc

# ~~~~~~~~~~~~~~~~~~~~ ONLY WHEN STARTING WITHOUT DEVCONTAINER ~~~~~~~~~~~~~~~~~~~~ #
# Include an entrypoint (script that run when starting the container) 
COPY .devcontainer/entrypoint.sh /entrypoint.sh
# Set execution permission
USER root
RUN chmod +x /entrypoint.sh
USER $USERNAME
# Configure the entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Default command to keep the container running (passed as an argument to the entrypoint) 
CMD ["bash"]