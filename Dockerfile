FROM ubuntu:xenial-20210416

LABEL mantainer="Eloy Lopez <elswork@gmail.com>"

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    libfreetype6-dev \
    libpng12-dev \
    libzmq3-dev \
    pkg-config \
    python \
    python-dev \
    python-pip \
    python-setuptools \
    python-scipy \
    rsync \
    software-properties-common \
    unzip \
    git \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG WHL_URL=https://storage.googleapis.com/tensorflow/linux/cpu/
ARG WHL_FILE=tensorflow-1.9.0-cp27-none-linux_x86_64.whl

RUN python -m pip install --upgrade pip && \
  pip --no-cache-dir install \
     ipykernel \
     jupyterlab \
     matplotlib \
     numpy \
     sklearn \
     pandas \
     ${WHL_URL}${WHL_FILE} && \
     rm -f ${WHL_FILE} && \
     python -m ipykernel.kernelspec	

COPY jupyter_notebook_config.py /root/.jupyter/

# Copy sample notebooks.
COPY notebooks /notebooks

# TensorBoard & Jupyter
EXPOSE 6006 8888

WORKDIR "/notebooks"

CMD jupyter lab --ip=* --no-browser --allow-root