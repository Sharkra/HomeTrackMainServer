#!/bin/bash
source ~/Dependencies/.webservervenv/bin/activate && \
flask --app application run --host=0.0.0.0 --port 8000 --debug