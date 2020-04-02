# TESTBENCH

To run the testbench, execute ./runtest.sh [<num_byte>].

The parameter num_byte specifies the number of bytes of each access (write & read). If the parameter is not specified, the alignment access will be 4 bytes by default. Take into account that the value of this parameter only can be 4/2/1 byte. 

This testbench writes and reads 10 (by default) consecutive memory addresses.
