Lab 02 Debugging
=======================================

##### This lab is mainly from the CP216 labs in [WLU](https://bohr.wlu.ca/cp216/labs)

The CPUlator: [https://cpulator.01xz.net/?sys=arm-de1soc](https://cpulator.01xz.net/?sys=arm-de1soc).

Debugging
---------

Debugging an assembly language program is conceptually no different than debugging a program written in a high-level language, though the details sometimes differ. To debug an assembly language program, follow these steps:

*   Know the results you expect - short of a program crashing, you cannot tell if there is an error if you do not know what your results should be.
*   Desk check your code - a careful reading of your source code often allows you to find your errors without resorting to executing the buggy code.
*   Examine the simulator listing for errors - lines with errors are well marked as such and an error message is given.
*   Syntax errors in assembly language code occur on one line only. Logic errors can be spread over many lines.
*   Trace your program line-by-line -- as you trace carefully examine three things:
    *   the register values -- are they what you expect?
    *   the memory location values -- are they what you expect?
    *   the actual instruction being executed -- are they what you wrote, or has the simulator translated your instruction into another form? Is this translation correct?
*   In assembly language you must particularly watch out for errors with respect to operand size -- are you properly assigning byte, word, or long word sizes to your operators and operands.
*   Are you using the correct number representation for your operands?
*   Do your comments correctly represent what your program is doing at that point?
*   Now that your program runs without errors, does it actually do what it is supposed to do?

* * *

Working with Memory
-------------------

The following program adds two values together and stores the result in memory:
    
```nasm
.org 0x1000 // Start at memory location 1000 
.text           // Code section 
.global _start 
_start: 

// Store data in registers 
mov r0, #4 
mov r1, #8 
add r2, r1, r0 

// Copy data to memory 
ldr r3, =Result  // Assign address of Result to r3 
str r2, [r3]     // Store contents of r2 to address in r3  

// End program 
_stop: 
b _stop  

.data 
.bss        // Uninitialized data section 
Result: 
.space 4    // Set aside 4 bytes for result  

.end
```
  


In order to access memory you must place the address of the memory location to be accessed in a register. Then that register can be used to access that memory location. Walk through this program line by line (as we showed last week) and see where `Result` is located in memory, and the value that is stored in `r3`.

### Directives

Memory can be defined in a number of ways, but for now we will use the ARM/GNU compiler directives `.data`, `.bss`, `.space`, and `.word`:

`.data`

- Defines a section of code that contains initialized data and variables rather than executable code. Generally this is placed after the exit instruction. It is the programmer's responsibility to make sure that the code placed in this section contains only data and variables.

`.bss`

- Defines a section of code that contains uninitialized variables rather than data or executable code. Generally this is placed after the exit instruction. It is the programmer's responsibility to make sure that the code placed in this section contains only space for variables.

`.space`

- Format: `{label} .space number_of_bytes`

- Reserves _number\_of\_bytes_ for data storage. By default the space is filled with 0s. The location in memory that is reserved is determined by where in the code the directive is placed.

- The directive:

          Answers:  .space  24
        

- Reserves 24 bytes of space in memory with the label _Answers_. In ARM, a word is 4 bytes of memory. ('Word' size varies from processor to processor.)

`.word`

- Format: `{label} .word value{, value}`

- Assigns one or more word size values to a location in memory.

= The directive:

          Multiple:  .word  10
        

- Reserves 4 bytes of memory for the decimal value 10 with the label _Multiple_.

- The instruction:

          Values:  .word  5, 6, 7, 8
        

- Reserves 16 bytes (4 values of 4 bytes each) of memory for the decimal values 5, 6, 7, and 8 with the label _Values_.

There are other directives to set aside different sizes of memory and strings - we will look at those in later labs.

### Instructions

The instructions used to access memory are: `ldr`, and `str`.

`ldr`

- This instruction loads a word-sized value from memory into a register.

- Formats:  
`ldr rd, [ra]`  
`ldr rd, =label`

`rd`

- The destination register.

`ra`

- The register containing the memory address to be read from.

`_label_`

- The label of a memory location to be read from.

- The instructions:

          ldr r0, =Multiple 
          ldr r1, [r0]
        

- copy the value stored at the memory location labeled `multiple` into `r1`. The first line copies the address of `Multiple` to register `r0`; the second line copies the contents of that address to r1.

`str`

- This instruction stores a word-sized value from a register into memory.

- Format: `str rd, [ra]`

`rd`

- The destination register.

`ra`

- The register containing the memory address to be written to.

- The instructions:

          ldr r4, =Answers
          str r1, [r4]
        

- copies the value stored in `r1` into the memory location labeled by `Answers`

`sub`

- This instruction stores the result of subtracting values from registers into a register.

- Format: `sub rd, rl, Rr`

`rd`

- The destination register.

`rl`

- The register containing the value to subtract from.

`rr`

- The register containing the value to subtract. i.e `rd = rl - rr`

- The instruction:

          sub r0, r2, r1
        

- subtracts the value in `r1` from the value in `r2` and puts the result in `r0`.

Task
==========================================
Put your written answers into a .doc or .pdf file with corresponding screenshots.

Identify and correct the errors in the following programs (use `save as` from your browser to download these files):

### program1

```nasm
/*
-------------------------------------------------------
errors1.s
-------------------------------------------------------
Author:
ID:
Email:
Date:
-------------------------------------------------------
Assign to and add contents of registers.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

// Copy data from memory to registers
ldr r3, A;
ldr r0, [r3]
ldr r3, B:
ldr r1, [r3]
add r2, r1, [r0]
// Copy data to memory
ldr r3, =Result // Assign address of Result to r3
str r2, [r3] // Store contents of r2 to address in r3
// End program
_stop:
b _stop

.data      // Initialized data section
A:
.word 4
B:
.word 8
.bss     // Uninitialized data section
Result:
.space 4 // Set aside 4 bytes for result

.end
```
### program2

```nasm
/*
-------------------------------------------------------
l02_t02.s
-------------------------------------------------------
Author:
ID:
Email:
Date:
-------------------------------------------------------
Assign to and add contents of registers.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

// Copy data from memory to registers
ldr r3, =First
ldr r0, [r3]
ldr r3, =Second
ldr r1, [r3]
// Perform arithmetic and store results in memory
add r2, r0, r1
ldr r3, =Total
str r2, r3
// Subtract Second from First
sub r2, r0, r1
ldr r3, =Difff
str r2, r3
// End program
_stop:
b _stop

.data // Initialized data section
First:
.word 4
Second:
.word 8
.bss // Uninitialized data section
Total:
.space 4 // Set aside 4 bytes for total
Diff:
.space 2 // Set aside 4 bytes for difference

.end
```

### program3

```nasm
/*
-------------------------------------------------------
errors3.s
-------------------------------------------------------
Author:
ID:
Email:
Date:
-------------------------------------------------------
Copies contents of one vector to another.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

.text // code section
// Copy contents of first element of Vec1 to Vec2
ldr r0, =Vec1
ldr r1, =Vec2
ldr r2, [r0]
str r2, [r1]
// Copy contents of second element of Vec1 to Vec2
add r0, r0, #2
add r1, r1, #2
ldr r2, [r0]
str r2, [r1]
// Copy contents of second element of Vec1 to Vec2
add r1, r1, #4
add r1, r1, #4
ldr r2, [r0]
str r2, [r2]
// End program
_stop:
b _stop

.data // Initialized data section
Vec1:
.word 1, 2, 3
.bss // Uninitialized data section
Vec2:
.word 6

.end
```

Note: Some of the results of your correct programs may look odd. Remember that you can display the contents of registers in three different ways. Which way makes the most sense to you in what context?

Zip your answers file into a file named _yourID\_l02.zip_. Upload this zip file to the Chaoxing Space.

* * *
