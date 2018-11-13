#!/bin/bash
# Author: Joel Turbi
# Final Project for CS265 - Unix System Programming
# Number guessing Game:
#                       This script asks the user to guess a random number
#                       between 1 and 100.It works in the folowing wayTuser is  prompted to guess a number between 1 and 100.
#                    The value entered is then compared to the number that was randomly generated.

Welcome()
{
  echo "          ***************************************************"
  echo "          *       Welcome Number Guessing Game              *"
  echo "          ***************************************************"
  echo
  read -p "<> What is your name: " name
  echo
}
Game(){
  # Calls Welcome function.
  Welcome
  # Randomizes number from 1-100
  Num=$((1+$RANDOM%100))
  Answer=""
  read -p "$name, I'm thinking of a number between 1-100! Try to guess the number I'm thinking of: " Guess
  while [[ "$Answer" != "no" ]]; do
    if [ "$Guess" -lt "$Num" ]; then
      read -p "Too low! Guess Again: " Guess
    elif [ "$Guess" -gt "$Num" ]; then
        read -p "Too High! Guess Again: " Guess
    else
      echo "Invalid input! Try again."
    fi
    if [ "$Num" -eq "$Guess" ]; then
      read -p "That's it! Would you like to play again? (yes/no) " Answer
      if [ "$Answer" == "yes" ]; then
        clear
        Welcome
        Num=$((1+$RANDOM%100))
        read -p "$name, I'm thinking of a number! Try to guess the number I'm thinking of: " Guess
      elif [ "$Answer" == "no" ]; then
        echo
        echo "Terminating in ..."
        for i in {10..1};do
          echo $i;
          sleep 0.4
        done
        echo "Thanks for playing!"
        echo "GoodBye!"
        exit 0
      else
        echo "Invalid input! Try again."
      fi
    fi
done
}
Game
