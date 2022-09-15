#!/bin/bash

systemctl enable continuous_deploy.timer
systemctl start continuous_deploy.timer

