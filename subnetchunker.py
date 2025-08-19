## Break down Subnet.
## Since some tools cant not handle scanning multiple large networks this tool will break down your subnets into chunks that the tool can handle.
## IE. Tenable Nessus chokes on it self after 2500 so scaning a /16 can be problematic. So you cna use this to break the /16 down in 24 chnunks using this.
## It will create a csv with each chunk, usally a /16 will generate 27 files, last one is the remaidner if the math is not even ever.
##
## Created by Michael AKA Genxweb

import csv

##Define chunk max 2500
chunk_size = 2499

##load the data

with open('subnets.csv') as csvDataFile:
    csvReader = csv.reader(csvDataFile)
    lst = list(csvReader)
    
output = [lst[i:i + chunk_size] for i in range(0, len(lst), chunk_size)]
for i in range(len(output)):
    fname = str(i+1)
    #print(fname + ".csv")
    with open(fname +".csv", 'w') as temp_file:
        for item in output[i]:
            temp_file.write("%s\n" % item)
    
    f = open(fname +".csv",'r')
    filedata = f.read()
    f.close()
    newdata = filedata.replace("['","")
    f = open(fname +".csv",'w')
    f.write(newdata)
    f.close()
    f = open(fname +".csv",'r')
    filedata = f.read()
    f.close()
    newdata = filedata.replace("']","")
    f = open(fname +".csv",'w')
    f.write(newdata)
    f.close()
            
 
