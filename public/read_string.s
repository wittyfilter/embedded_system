/*
-------------------------------------------------------
read_string.s
-------------------------------------------------------
Author:  David Brown
ID:      123456789
Email:   dbrown@wlu.ca
Date:    2023-07-31
-------------------------------------------------------
Reads a string from the UART
-------------------------------------------------------
*/
// Constants
.equ UART_BASE, 0xff201000     // UART base address
.equ SIZE, 80        // Size of string buffer storage (bytes)
.equ VALID, 0x8000   // Valid data in UART mask

.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

// read a string from the UART
ldr  r1, =UART_BASE
ldr  r4, =READ_strING
add  r5, r4, #SIZE // store address of end of buffer

LOOP:
ldr  r0, [r1]      // read the UART data register
tst  r0, #VALID    // check if there is new data
beq  _stop         // if no data, return 0
strb r0, [r4]      // store the character in memory
add  r4, r4, #1    // move to next byte in storage buffer
cmp  r4, r5        // end program if buffer full
beq  _stop
b    LOOP

_stop:
b _stop

.data  // Data section
// Set aside storage for a string
READ_strING:
.space    SIZE

.end
