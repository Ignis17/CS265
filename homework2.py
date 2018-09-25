# Author: Joel Turbi
# Course: CS265
# Assignment: Homework#2
# Created: 09/24/2018

"""
- This module provides a portable way of using operating system dependent functionality. 
- os.system(command): Execute the command (a string) in a subshell. 
- This is implemented by calling the Standard C function system(), and has the same limitations.
  Changes to sys.stdin, etc. are not reflected in the environment of the executed command. 
  If command generates any output, it will be sent to the interpreter standard output stream.

- On Unix, the return value is the exit status of the process encoded in the format specified for wait().
  Note that POSIX does not specify the meaning of the return value of the C system() function, 
  so the return value of the Python function is system-dependent.

- On Windows, the return value is that returned by the system shell after running command.
  The shell is given by the Windows environment variable COMSPEC: it is usually cmd.exe,
  which returns the exit status of the command run; on systems using a non-native shell, consult your shell documentation.

- The subprocess module provides more powerful facilities for spawning new processes and retrieving their results;
  using that module is preferable to using this function. 

	Availability: Unix, Windows.
"""
import os

def Menu():
        # Empty declation of input variable
		choice=""
        # Title of program
		print("\n** Homework#2 **\n")
		# While loop that iterates through display menu to ask user for desired choice/task. It will terminate once 4 is entered.
		while(choice != 4):
			# Display Menu
			print("1) Display your current directory.")
			print("2) Display your home directory.")
			print("3) List the contents of your current directory.")
			print("4) Exit")
			# Get input from user
			choice=int(input("Please select a menu item:\n"))
			# Conditional statements to determine user's choice/task
			if(choice == 1):
				os.system("clear")
				print("\n** Current directory **\n")
				os.system("pwd")
				print("\n_______________________\n")
			elif(choice == 2):
				os.system("clear")
				print("\n** Home directory **\n")
				os.system("echo $HOME")
				print("\n____________________\n")
			elif(choice == 3):
				os.system("clear")
				print("\n** List of contents from current directory **\n")
				os.system("ls .")
				print("\n_____________________________________________\n")
			# Once user enters the number 4, a countdown is executed. Counting down from 10-1 and then displays the message "Blast off!". 
			elif(choice == 4):
				os.system("clear")
				countdown = 10
				for count in range(countdown, 0, -1):
					print(count)
				print("\nBlast off!\n")
			# Default case, will only execute if user inputs a choice not given in display menu.
			else:
				print("\nInvalid input. Try again!\n")
# Function call
Menu()