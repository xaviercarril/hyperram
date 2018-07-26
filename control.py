#!/usr/bin/python
import serial
import csv
import struct
import time

ser=serial.Serial()
ser.port="/dev/ttyUSB1"
ser.baudrate=115200
ser.timeout=1
ser.open()

cmds = { 
    'ADDR' : 1 ,
    'LOAD' : 2,
    'WRITE' : 3,
    'READ' : 4,
    'READ_REQ' : 5,
    'COUNT': 6,
    'CONST': 7,
    }

def cmd(cmd, data=0):
    ser.write(struct.pack('B', cmds[cmd] ))
    ser.write(struct.pack('>I', data))
    # final byte to register the instruction
    ser.write(struct.pack('B', 0 ))
    # couldn't get 4 bytes to work - so reading 5!
    data = ser.read(5)
    b, data, = struct.unpack('>BI', data)
    print(cmd, data )
    return data

write = True
read = True
with open("dumpvar" + '.csv', 'wb') as csvfile:
    wr = csv.writer(csvfile, delimiter=',')
    for i in range(100): # currently works up to 98
        data = cmd('ADDR', i)
        if write:
            cmd('LOAD', i)
            cmd('WRITE')
        if read:
            cmd('READ_REQ')
            read_data = cmd('READ')

        if read and write:
            if(read_data == i):
                print("pass")
            else:
                print("failed at addr %d, was %d" % (i, read_data))

        print("----")
        #wr.writerow([i, leds, addr, data])