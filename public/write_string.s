/*
-------------------------------------------------------
write_string.s
-------------------------------------------------------
Author:  David Brown
ID:      123456789
Email:   dbrown@wlu.ca
Date:    2023-07-31
-------------------------------------------------------
Writes a string to the UART
-------------------------------------------------------
*/
// Constants            
.equ UART_BASE, 0xff201000     // UART base address

.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

// print a text string to the UART
ldr  r1, =UART_BASE
ldr  r4, =TEXT_strING
        
LOOP:
ldrb r0, [r4]    // load a single byte from the string
cmp  r0, #0
beq  _stop       // stop when the null character is found
str  r0, [r1]    // copy the character to the UART DATA field
add  r4, r4, #1  // move to next character in memory
b LOOP

_stop:
b _stop

.data  // Data Section
// Define a null-terminated string
TEXT_strING:
.asciz    "This is a text string"

.end
