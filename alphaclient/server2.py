from flask import Flask, request
import redis
import json
import os
from collections import Counter
import requests

app = Flask(__name__)
@app.route('/', methods = ['GET'])
def monit():

    node = ['localhost','localhost']
    arr = []
    for data in node: 
      r = requests.get('http://'+data+':4444')
      resp = str(r.json())
      #arr.append("IP "+node+" "+resp)
      arr.append(resp)
    #listToStr = '<br>'.join(map(str, arr))
    return(str(arr))

if __name__ == '__main__':
   app.run(debug=True)
