#!/bin/bash
docker stop moodle_dev_arm
docker rm moodle_dev_arm
docker run -d --name "moodle_dev_arm" -p "80:80" -p "443:443" -v "/var/www:/var/www"  oswmilanez/moodle_dev_arm:latest

