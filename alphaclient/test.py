with open("/tmp/output.log", "r+") as f:
     old = f.read() # read everything in the file
     f.seek(0) # rewind
     line = f.readline()
     print(line)
     '''cnt = 1
     while line:
         #return("Line {}: {}".format(cnt, line.strip()))
         #line = fp.readline()
         #f.write("{'message':'" + old + "'}")
         f.write("{'message':'" + old + "'}")
         break'''

