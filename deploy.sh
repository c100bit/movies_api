#!/bin/bash
git add .
git ci -am 'deploy'
git push master
git push heroku master
