from flask import Flask, request
import redis
import json
import os
from collections import Counter

app = Flask(__name__)
passwd = os.environ["redis_pwd"] 
@app.route('/', methods = ['GET'])
def monit():
  r = redis.StrictRedis(host="localhost", port=6379, db=0, password=passwd)
  l = r.lrange('filebeat', 0, -1)
  val=[]
  arr=[]
  for x in l:
    data=(json.loads(x))
    string = data['message']
    error=['Connection closed by authenticating user']
    if any(x in string for x in error):
      val.append(str(data['host']['name']+' ('+data['host']['ip'][0]+')'))
  c = dict(Counter(val) )
  title = 'Metrics for ssh log-in attempts<br>'
  for resp in c.items():
    arr.append('* '+resp[0]+' had '+str(resp[1])+' attempt')
  listToStr = '<br>'.join(map(str, arr)) 
  return(title+listToStr)
if __name__ == '__main__':
    app.run(debug=True)
