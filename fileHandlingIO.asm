# Prompt: Write a program in assembly that will 
#		1. Open a file 
#		2. Read an existing file (can be any file you have) 
#			2a. Print file contents to user in Run I/O tab 
#		3. Write to a new file 
#		4. Close a file 

# Author: Andrew Lam & Tyler Hipolito 
# Course: CS2640.01 
# Due Date: 12/07/2022
# Objective: Implement file handling to practice opening, reading/writing, and closing a file 

# macro to exit the program 
.macro exit 
li $v0, 10 
syscall
.end_macro

.data 
	file1name: .asciiz "cs2640Terms.txt" 
	file2name: .asciiz "fileHandlingOutput.txt"
	buffer: .space 32

.text 
main: 
	# open the file with flag - read 
	li $v0, 13		# service number 13 
	la $a0, file1name	# load the name of the file we are opening into $a0 
	li $a1, 0		# flag: 0 - read [open for reading] 
	li $a2 0 		# mode: ignored [always gonna have this line of code but it doesn't do anything] 
	syscall 
	move $s0, $v0 		# move $v0 (file descriptor) into $s0, so we know the status
	
	# read the file 
	li $v0, 14		# service number 14 
	move $a0, $s0		# move $s0 (from opening file code) into $a0 (file descriptor) 
	la $a1, buffer 	# load aBuffer into $a1 as address of input buffer 
	li $a2, 300 		# load 300 into $a2, allocate 300 chars to be read 
	syscall 
	
	# print the contents of the read file to the user 	
	li $v0, 4 
	la $a0, buffer
	move $a0, $a1 
	syscall 
	
	
	# open a new file to write 
	li $v0, 13		# service number 13 
	la $a0, file2name	# load the name of the file we are opening into $a0 
	li $a1, 1		# flag: 1 - write 
	li $a2 0 		# mode: ignored [always gonna have this line of code but it doesn't do anything] 
	syscall 
	move $s0, $v0 		# move $v0 (file descriptor) into $s0, so we know the status
	
	# write to a new file 
	li $v0, 15 		# service number 15 
	move $a0, $s0 		# move $s0 into $a0 (file descriptor) 
	la $a1, buffer		# load bBuffer into $a1 as address of output buffer 
	li $a2, 300 		# load 300 into $a2, allocate 300 chars as limit to write 
	syscall 
	
	
	# close the file 
	li $v0, 16 		# service number 16 
	move $a0, $s0 		# move $s0 into $a0 (file descriptor) 
	syscall 	
	
	exit 
	
	
