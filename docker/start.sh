#!/bin/bash

cd "$(dirname "$0")"

workspace_dir=$PWD


desktop_start() {
    xhost +local:
    docker run -it -d --rm \
        --gpus all \
        --ipc host \
        --network host \
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --privileged \
        --name ai_journey_research \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        -v $workspace_dir/../src:/home/docker_current/src:rw \
        ${ARCH}/ai_journey_research:latest
    xhost -
}




#  -v /media/cds-k/Elements/train_whisper_cache:/home/docker_current/.cache:rw \
# -v /media/cds-k/Elements/some_models_weight/whisper:/home/docker_current/whisper_weights:rw \

main () {
    ARCH="$(uname -m)"

    if [ "$ARCH" = "x86_64" ]; then
        desktop_start;
    elif [ "$ARCH" = "aarch64" ]; then
        arm_start;
    fi

}

main;
