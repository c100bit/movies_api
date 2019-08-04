#!/bin/bash
git add .
git ci -am 'deploy'
git push heroku master
heroku run rails db:migrate

