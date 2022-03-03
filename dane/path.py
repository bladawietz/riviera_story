import math


### sciezka dla joysticka

x0=140
y0=140
steps=120
RX=80
RY=70
path=[]



for i in xrange (0,steps):
    x=int(x0+RX*math.cos(i*2*math.pi/steps))
    path.append(x)
    y=int(y0+RY*math.sin(i*2*math.pi/steps))
    path.append(y)
    #print x,y

file = open("sciezka_1_2.bin", "wb")
binary_format = bytearray(path)
file.write(binary_format)
file.close()


### sciezka dla myszki

x0=50
y0=215
steps=120
RX=20
INX=1.5

path=[]
for i in xrange (0,steps):
    x=x0+int(INX*i)+int(RX*math.cos(3*i*2*math.pi/steps))
    path.append(x)
    path.append(y0)
    #print x,y0

file = open("sciezka_1_3.bin", "wb")
binary_format = bytearray(path)
file.write(binary_format)
file.close()