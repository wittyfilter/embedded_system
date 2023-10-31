/*
-------------------------------------------------------
l05_t01.s
-------------------------------------------------------
Author:  David Brown
ID:      123456789
Email:   dbrown@wlu.ca
Date:    2023-07-31
-------------------------------------------------------
Uses a subroutine to print strings to the UART.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr r4, =First
bl  PrintString
ldr r4, =Second
bl  PrintString
ldr r4, =Third
bl  PrintString
ldr r4, =Last
bl  PrintString

_stop:
b    _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address
.equ ENTER, 0x0A            // The enter key code

PrintString:
/*
-------------------------------------------------------
Prints a null terminated string with an ENTER at the end.
-------------------------------------------------------
Parameters:
  r4 - address of string to print
Uses:
  r0 - holds character to print
  r1 - address of UART
-------------------------------------------------------
*/
stmfd sp!, {r0, r1, r4}  // preserve temporary registers
ldr   r1, =UART_BASE     // get address of UART

psLOOP:
ldrb  r0, [r4], #1       // load a single byte from the string
cmp   r0, #0
beq   _PrintString       // stop when the null character is found
str   r0, [r1]           // copy the character to the UART DATA field
b     psLOOP
_PrintString:
ldmfd sp!, {r0, r1, r4}  // recover temporary registers
bx    lr                 // return from subroutine

.data
.align
// The list of strings
First:
.asciz  "First string"
Second:
.asciz  "Second string"
Third:
.asciz  "Third string"
Last:
.asciz  "Last string"
_Last:    // End of list address

.end
