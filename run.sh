#!/bin/bash

mkdir -p data
mkdir -p local_data

CUR_DIR="$(pwd)"

case "$1" in
    build_generator)
        docker build --no-cache -t hw-generator ./generator
        ;;
    run_generator)
        docker run --rm -v "$CUR_DIR/data:/data" hw-generator
        ;;
    create_local_data)
        python3 generator/generate.py ./local_data
        ;;
    build_reporter)
        docker build --no-cache -t hw-reporter ./reporter
        ;;
    run_reporter)
        docker run --rm -v "$CUR_DIR/data:/data" hw-reporter
        ;;
    structure)
        if command -v tree &> /dev/null; then
            tree -a -I '.git|.idea'
        else
            find . -not -path '*/\.*' | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
        fi
        ;;
    clear_data)
        rm -rf data/*
        ;;
    inside_generator)
        docker run --rm -v "$CUR_DIR/data:/data" hw-generator ls -la /data
        ;;
    inside_reporter)
        docker run --rm -v "$CUR_DIR/data:/data" hw-reporter ls -la /data
        ;;
    *)
        exit 1
        ;;
esac