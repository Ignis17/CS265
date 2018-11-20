#!/bin/bash

# Author: Joel Turbi
# Final Project for CS265 - Unix System Programming
# Number guessing Game:
#                       This script asks the user to guess a random number
#                       between 1 and 100. It works in the folowing way;
#												the user is  prompted to guess a number between 1 and 100,
#                       then value entered is then compared to the number that was randomly generated.

# Set bash to quit script and exit on errors:
# 																						The -e option means "if any pipeline ever ends with a non-zero ('error') exit status,
# 																						terminate the script immediately". Since grep returns an exit status of 1 when it doesn't
# 																						find any match, it can cause -e to terminate the script even when there wasn't a real "error".

set -e
# Declare score and temporary files as well as empty variables.
Name=""
Score="/tmp/score.txt"
TempFile="/tmp/tempscore.txt"
if [ ! -f $Score ]; then
	touch $Score
fi

### Beginning of Functions ###
# Color coded heading: Sets up borders to green, while underlining and setting the color red to title and credits.
Welcome(){
	# Clears the terminal screen everytime Welcome() is called.
	clear
	echo
	echo -e "          \e[1;92m***************************************************\e[0m"
	echo -e "          \e[1;92m*\e[0m       \e[1;4;91mWelcome to The Number Guessing Game\e[0m       \e[1;92m*\e[0m"
	echo -e "          \e[1;92m*\e[0m                 \e[1;91mBy: Joel Turbi                  \e[1;92m*\e[0m"
	echo -e "          \e[1;92m***************************************************\e[0;94m"
	echo
}

GenerateStats(){
	cat "$Score" | sort -k1n | head -10 > "$TempFile" && mv "$TempFile" "$Score"
	HighTen=$(cat "$Score")
	HighNum=$(head -1 "$Score" | awk -F',' '{ print $1 }')
	HighName=$(head -1 "$Score" | awk -F',' '{ print $2 }')
	HighTotal=$(tail -1 "$Score" | awk -F',' '{ print $1 }')
	echo -e "The Top 10 Players are:\n" && \
	awk -F',' 'BEGIN { printf "%-10s %-10s %-10s\n", "Rank","Name","Score"
											printf "%-10s %-10s %-10s\n", "----","----","-----" }
			 { printf "%-10s %-10s %-10s\n", " "NR".",$2," "$1 }' "$Score"
	echo
}

# Get Player's guess and validate input
Guess(){
	Validate(){
		while ! [[ $Guess -lt 101 || $Guess -gt 0 ]]; do
			read -p "<>    $Name, that was not a valid guess.\n Try that again: " Guess
		done
	}
	if [ $g -eq 1 ]; then
		read -p "<>    $Name, Enter your first guess: " Guess
		Validate
		let FirstGuess="$Guess"
	else
		read -p "Enter a new guess: " Guess
		Validate
		let NewGuess="$Guess"
	fi
}

# Generate random number.
RandomNumber(){
	let Random=$RANDOM%100;
}

# Calculate the difference between the players guesses as absolute value.
GuessDiff(){
	OldDiff=$(($Random - $OldGuess))   # Calculates difference between old guess and random number.
	NewDiff=$(($Random - $NewGuess))   # Calculates difference between new guess and random number.

	if [[ $OldDiff -lt 0 ]]; then
		 let "ABSVAL_OLDGDIFF=( 0 - $OldDiff )"
	else
		 let ABSVAL_OLDGDIFF="$OldDiff"
	fi
	if [[ $NewDiff -lt 0 ]]; then
		 let "ABSVAL_NEWGDIFF=( 0 - $NewDiff )"
	else
		 let ABSVAL_NEWGDIFF="$NewDiff"
	fi
}

# Calculate high score
Calculate(){
	if [[ $g -lt $HighNum ]]; then
		echo -e "Congratulations $Name. You have the new high score!"
		echo -e "The previous holder of this record was $HighName\n"
	elif [[ $g -eq $HighNum ]]; then
		echo -e "Congratulations $Name... You are tied with $HighName for 1st place!\n"
	elif [[ $g -lt $HighTotal ]]; then
		echo -e "Congratulations $Name... You made it into the Top 10 list!\n"
	else
		echo -e "I'm sorry $Name, you did not make the Top 10 list this time. Please try again!\n"
	fi
	echo "$g,$Name" >> $Score
	GenerateStats
}

#Repeat game function
Repeat(){
	read -n 1 -p "Play Again? (Y/N): " Answer
	case $Answer in
    Y|y)
      echo ""
      RandomNumber && Game
      ;;
    N|n|*)
      Exit;;
  esac
}

Game(){
	#To see the number for debugging, uncomment the following line
	echo "the random number is $Random"
	Welcome
	GenerateStats
	if [[ ! "$Name" ]]; then
		read -p "Enter your name: " Name
	fi
	echo
	let g=1 && Guess

	if [[ $FirstGuess -eq $Random ]]; then
		 echo -e "\n"$Name", You must be very special... You guessed it on the first try!\n"
		 Calculate && Repeat
	else
		 let OldGuess=$FirstGuess
		 echo "Sorry, please try again..."
		 let g=2 && Guess

		 for ((g=2; NewGuess != "$Random"; ++g)); do
			 GuessDiff	# call func gdiff to calculate difference between guesses
	if [[ "$ABSVAL_OLDGDIFF" -lt "$ABSVAL_NEWGDIFF" ]]; then
		let OldGuess=$NewGuess
		echo "<>     You're getting colder..."
		Guess
	 else
		 let OldGuess=$NewGuess
		 echo "<>    You're getting warmer..."
		 Guess
	 fi
 done
 echo -e "\n"$Name"... You guessed it in "$g" tries!\n"
 Calculate && Repeat
fi
}

# Color coded closing function: Sets up borders of farewell message in green, while keeping
Exit(){
	echo
	echo -e "\e[1;92m**********************************************\e[0m"
	echo -e "\e[94m<>\e[0m	\e[1;91mThanks for playing $Name!\e[0m"
	echo -e "\e[94m<>\e[0m	\e[1;91mGoodbye!\e[0m"
	echo -e "\e[1;92m**********************************************\e[0m"
	echo
}
### Ending of Functions ###
RandomNumber && Game
