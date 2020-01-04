export LC_ALL=en_US.utf-8;

export LANG=en_US.utf-8;

export FLASK_APP=./alphaserver/server.py

export redis_pwd=$1

flask run -h 0.0.0.0 -p 5555
