# Let's start from an official debian docker image - feel free to update the tag
# as needed.
FROM debian:13.0
ENV DEBIAN_FRONTEND=noninteractive

# Install packages here
RUN apt-get update && apt-get -y install --no-install-recommends adduser \
  ca-certificates wget && \
  apt-get clean autoclean && \
  apt-get autoremove

# Install Miniconda (pinned version, edit as needed)
ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py39_25.5.1-1-Linux-x86_64.sh -O ./miniconda-Linux-x86_64.sh && \
  bash ./miniconda-Linux-x86_64.sh -b -p $CONDA_DIR && \
  rm ./miniconda-Linux-x86_64.sh && \
  conda clean -afy

# Copy and create conda environment
COPY environment.yml .
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main \
  && conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
RUN conda env create -f environment.yml && conda clean -afy

# Create group and user to avoid permissions issues with local user/group
# when editing files in and out of docker container.
# Note: GNU/Linux systems assign the default 1000 User Identifier (UID) and
# Group Identifier (GID) to the first account created during installation. It is
# possible that your local UID and GID on your machine may be different, in that
# case you should edit the values in the commands below.
# You can see your UID and GID(s) by executing: `id`
RUN addgroup --gid 1000 groupname
RUN adduser --disabled-password --gecos "" --uid 1000 --gid 1000 username
ENV HOME=/home/username
USER username