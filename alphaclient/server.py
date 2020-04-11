from flask import Flask, request
import redis
import json
import os
from collections import Counter

app = Flask(__name__)
passwd = os.environ["redis_pwd"] 
@app.route('/', methods = ['GET'])
def monit():

  f = open("/tmp/output.log","r")
  return(str(f.read()))

if __name__ == '__main__':
    app.run(debug=True)
