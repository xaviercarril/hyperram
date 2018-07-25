#!/usr/bin/python
import serial
import csv
import struct
import time

ser=serial.Serial()
ser.port="/dev/ttyUSB1"
ser.baudrate=115200/4  # clock in fpga is divided by 4 to get the ram working
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

# currently only writes 1 byte instead of 4
def cmd(cmd, data=0):
    # don't know why but pyserial won't read 6 bytes after doing the writes. Have to interleave
    ser.write(struct.pack('B', cmds[cmd] ))
    d = ""
    d += ser.read(1)
    ser.write(struct.pack('B', 0))
    d += ser.read(1)
    ser.write(struct.pack('B', 0))
    d += ser.read(1)
    ser.write(struct.pack('B', 0))
    d += ser.read(1)
    ser.write(struct.pack('B', data))
    d += ser.read(1)
    # final byte to register the instruction
    ser.write(struct.pack('B', 0 ))
    d += ser.read(1)

    out_str = ""
    for i in d[0:4]:
        out_str += str(ord(i)) + ","
       
    data, = struct.unpack('>I', d[0:4])
    print(cmd,  out_str, data )

with open("dumpvar" + '.csv', 'wb') as csvfile:
    wr = csv.writer(csvfile, delimiter=',')
    for i in range(100, 110):
        print(i)
        cmd('ADDR', i)
        cmd('LOAD', i)
        cmd('WRITE')
        cmd('READ_REQ')
        cmd('READ')
        print("----")
        #wr.writerow([i, leds, addr, data])
