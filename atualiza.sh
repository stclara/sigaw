#!/bin/bash
git add .
git commit -a -m "Atualização $(date '+%d-%m-%Y--%H:%M')"
git push heroku master
heroku run rake db:migrate

