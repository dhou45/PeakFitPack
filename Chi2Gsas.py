import os,math

fileList = os.listdir('.')

for name in fileList:
    if '.chi' in name or '.xy' in name:
        outputfile = open(name.replace('.chi','.fxye').replace('.xy','.fxye'),'w')
        print name
        x,y,z = [],[],[]

        for line in open(name,'r'):
            temp = line.split()
            try:
                float(temp[1])
                x.append( float(temp[0]) * 100 )
                y.append( float(temp[1]) )
                if float(temp[1]) < 0:
                    z.append(0)
                else:
                    z.append( math.sqrt( float( temp[1] ) ) )
            except:
                pass
    
        i = 0
        avg = 0
        for i in xrange(1,len(x)):
            avg = avg + x[i] - x[i-1]
                    
        avg = avg / i
    
        outputfile.write(name+'\n')
        outputfile.write('BANK 1 ' + str(len(x)) + ' ' + str(len(x)) + ' CONS ' + str(x[0]) + ' ' + str(avg) + ' 0 0 FXYE\n' )
    
        print len(x),len(y),len(z)
        for i in xrange(len(x)):
            outputfile.write( str(x[i]) + '\t' + str(y[i]) + '\t' + str(z[i]) + '\n')



