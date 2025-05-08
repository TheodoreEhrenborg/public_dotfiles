#!/usr/bin/env bash
ssh $1 cat clip | xclip -sel clip
