#!/usr/bin/python
import serial
import csv
import struct

ser=serial.Serial()
ser.port="/dev/ttyUSB2"
ser.baudrate=115200
ser.timeout=1
ser.open()

STEP = 0
LED = 1
READ_REQ = 2
ADDR = 3
DATA = 4
WRITE_1 = 5
WRITE_0 = 6

def step():
    # take a step
    ser.write(struct.pack('B', STEP ));
    data = ser.read(1)

def write():
    ser.write(struct.pack('B', WRITE_1 ));
    ser.write(struct.pack('B', WRITE_0 ));

def read(reg):
    print(reg)
    ser.write(struct.pack('B', reg ));
    data = ser.read(1) # 1 byte hard coded
    data, = struct.unpack('B', data)
    return data

with open("dumpvar" + '.csv', 'wb') as csvfile:
    wr = csv.writer(csvfile, delimiter=',')
    for i in range(10):
        print(i)
        leds = read(LED)
        addr = read(ADDR)
        read(READ_REQ)
        data = read(DATA)
        #write()

        wr.writerow([i, leds, addr, data])
