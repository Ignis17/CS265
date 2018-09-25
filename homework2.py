import os

def Menu():

	choice=""
 
	while(choice != 4):
		print("\n1) Display your current directory.")
		print("2) Display your home directory.")
		print("3) List the contents of your current directory.")
		print("4) Exit")

		choice=int(input("Please select a menu item:\n"))

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
		elif(choice == 4):
			os.system("clear")
			countdown = 10
			for count in range(countdown, 0, -1):
				print(count)
			print("\nBlast off!\n")
		else:
			print("\nInvalid input. Try again!\n")
Menu()
