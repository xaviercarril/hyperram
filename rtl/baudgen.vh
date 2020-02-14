//-----------------------------------------------------------------------------
//-- Constantes para el modulo de generacion de baudios para comunicaciones serie
//------------------------------------------------------------------------------
//-- (C) BQ. September 2015. Written by Juan Gonzalez (Obijuan)
//------------------------------------------------------------------------------

//-- Para la icestick el calculo es el siguiente si va a 100MHz:
//-- Divisor = 100 000 000 / BAUDIOS  (Y se redondea a numero entero)

//-- Valores de los divisores para conseguir estos BAUDIOS:

//`define B115200 104 //12MHz
//`define B115200 26 //12MHz
`define B115200 208 //24MHz
//`define B115200 416 //48MHz
//`define B115200 555 //64MHz
//`define B115200 833 //96MHz
//`define B115200 842 //97MHz
//`define B115200 850 //98MHz
//`define B115200 859 //99MHz
//`define B115200 868 //100MHz
`define BTEST 4

