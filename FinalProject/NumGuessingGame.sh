#!/bin/bash
# Author: Joel Turbi
# Final Project for CS265 - Unix System Programming
# Number guessing Game:
#                       This script asks the user to guess a random number
#                       between 1 and 100.It works in the folowing wayTuser is  prompted to guess a number between 1 and 100.
#                       The value entered is then compared to the number that was randomly generated.

Welcome(){
	clear
	echo "          ***************************************************"
	echo "          *       Welcome to The Number Guessing Game       *"
	echo "          *                 By: Joel Turbi                  *"
	echo "          ***************************************************"
	echo
}
Exit(){
	echo
	echo "      **********************************"
	echo "      *    Thanks for playing $Name!   *"
	echo "      *    Goodbye!                    *"
	echo "      **********************************"
	exit 0
}
NewUser(){
	# Calls Welcome function.
  Welcome
  read -p "<>    What is your name: " Name
  echo
  # Randomizes number from 1-100
  Num=$((1+$RANDOM%100))
  read -p "<>    $Name, I'm thinking of a number between 1-100! Try to guess the number I'm thinking of: " Guess
}
User(){
	# Calls Welcome function.
  Welcome
  # Randomizes number from 1-100
  Num=$((1+$RANDOM%100))
  read -p "<>    $Name, I'm thinking of a number between 1-100! Try to guess the number I'm thinking of: " Guess
}

Game(){
	# Declaration of empty string.
	Answer=""
	NewUser
  while [[ "$Answer" != "no" || "$Answer" != "No" || "$Answer" != "NO" ]]; do
    if [ "$Guess" -lt "$Num" ]; then
      read -p "<>    Too low! Guess Again: " Guess
    elif [ "$Guess" -gt "$Num" ]; then
        read -p "<>    Too High! Guess Again: " Guess
    fi
    if [ "$Num" -eq "$Guess" ]; then
      read -p "<>    That's it! Would you like to play again? (yes/no) " Answer
      if [[ "$Answer" == "yes" || "$Answer" == "Yes" || "$Answer" == "YES" ]]; then
        read -p "<>    Is this a new player? (yes/no) " Answer2
				if [[ "$Answer2" == "yes" || "$Answer2" == "Yes" || "$Answer2" == "YES" ]]; then
					NewUser
				else
					User
				fi
      elif [[ "$Answer" == "no" || "$Answer" == "No" || "$Answer" == "NO" ]]; then
        Exit
      else
        echo "<>    Invalid input! Try again."
      fi
    fi
done
}
Game
