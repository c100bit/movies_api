#!/bin/bash
git add .
git ci -am 'deploy'
git push origin master
git push heroku master

