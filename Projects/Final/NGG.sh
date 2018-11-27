#!/bin/bash

# Author: Joel Turbi
# Final Project for CS265 - Unix System Programming
# Number guessing Game:
#                       This script asks the user to guess a random number
#                       between 1 and 100. It works in the folowing way;
#												the user is  prompted to guess a number between 1 and 100,
#                       then value entered is then compared to the number that was randomly generated.

# Set bash to quit script and exit on errors:
# 											The -e option means "if any pipeline ever ends with a non-zero ('error') exit status,
# 											terminate the script immediately". Since grep returns an exit status of 1 when it doesn't
# 											find any match, it can cause -e to terminate the script even when there wasn't a real "error".
#set -e

# Declare score and temporary files as well as empty variables.
Name="";
Score="/tmp/score.txt";
TempFile="/tmp/tempscore.txt";
if [ ! -f $Score ]; then
	touch $Score;
fi

### Beginning of Functions ###
# Color coded heading: Sets up borders to green, while underlining and setting the color red to title and credits.
Welcome(){
	# Clears the terminal screen everytime Welcome() is called.
	clear;
	echo;
	echo -e "          \e[1;92m***************************************************\e[0m";
	echo -e "          \e[1;92m*\e[0m       \e[1;4;91mWelcome to The Number Guessing Game\e[0m       \e[1;92m*\e[0m";
	echo -e "          \e[1;92m*\e[0m                 \e[1;91mBy: Joel Turbi                  \e[1;92m*\e[0m";
	echo -e "          \e[1;92m***************************************************\e[0;94m";
	echo;
}

# Generates Statistics of player's total number of guesses as well as any previous top scores.
GenerateStats(){
	# sort -k1n: Uses the first field as a numeric value and sorts it numerically.
	# head -10: Displays the first 10 lines from the head/beginning of file (It disregards the any lines after line # 10). It then stores the output to $TempFile.
	# mv $TempFile $Score: cuts/moves output of $TempFile into $Score.
	cat "$Score" | sort -k1n | head -10 > "$TempFile" && mv "$TempFile" "$Score";
	# Stores the output $Score into variable named HighTen (Keeps score of the top 10 players).
	HighTen=$(cat "$Score");
	# Score board formatting.
	# Rank
	HighNum=$(head -1 "$Score" | awk -F',' '{ print $1 }');
	# Name of players
	HighName=$(head -1 "$Score" | awk -F',' '{ print $2 }');
	# Score - Overall number of guesses players took.
	HighTotal=$(tail -1 "$Score" | awk -F',' '{ print $1 }');
	echo -e "\e[1;92mThe Top 10 Players are:\n" && \
	awk -F',' 'BEGIN { printf "%-10s %-10s %-10s\n", "Rank","Name","Score"
											printf "%-10s %-10s %-10s\n", "----","----","-----" }
			 { printf "%-10s %-10s %-10s\n", " "NR".",$2," "$1 }' "$Score";
	echo -e "\e[0;94m";
}

# Gets player's guess and validates input.
Guess(){
	Validate(){
		while ! [[ $Guess -lt 101 && $Guess -gt 0 && $Guess =~ ^[0-9]+$ ]]; do
			echo -e "<>    $Name, that was not a valid guess."
			read -p "<>    Try that again: " Guess
		done;
	}
	if [ $tries -eq 1 ]; then
		read -p "<>    Hi $Name, I am thinking of a number from 1-100. Try to guess the number I am thinking of: " Guess;
		Validate;
		let FirstGuess=$Guess;
	else
		read -p "<>    Enter a new guess: " Guess;
		Validate;
		let NewGuess=$Guess;
	fi
}

# Generate random number.
RandomNumber(){
	# Randomizes numerical value from 1 to 100.
	let Random=(1+$RANDOM%100);
}

# Calculate the difference between the players guesses as absolute value.
GuessDiff(){
	OldDiff=$(($Random - $OldGuess));   # Calculates difference between old guess and random number.
	NewDiff=$(($Random - $NewGuess));   # Calculates difference between new guess and random number.

	if [[ $OldDiff -lt 0 ]]; then
		 let AOD=( 0 - $OldDiff );
	else
		 let AOD=$OldDiff;
	fi
	if [[ $NewDiff -lt 0 ]]; then
		 let AND=( 0 - $NewDiff );
	else
		 let AND=$NewDiff;
	fi
}

# Calculate high score
Calculate(){
	if [[ $tries -lt $HighNum ]]; then
		echo -e "<>    Congratulations $Name. You have the new high score!";
		echo -e "<>    The previous holder of this record was $HighName\n";
	elif [[ $tries -eq $HighNum ]]; then
		echo -e "<>    Congratulations $Name. You are tied with $HighName for 1st place!\n";
	elif [[ $tries -lt $HighTotal ]]; then
		echo -e "<>    Congratulations $Name. You made it into the Top 10 list!\n";
	else
		echo -e "<>    I'm sorry $Name, you did not make the Top 10 list this time. Please try again!\n";
	fi
	echo "$tries,$Name" >> $Score;
	GenerateStats;
}

#Repeat game function
Repeat(){
	read -p "<>    Would you like to play again? (yes/no) : " Answer;
	case $Answer in
    Yes|yes|YES|y|Y)
      echo;
      RandomNumber && Game;;
    No|no|NO|n|N|*)
			echo;
      Exit;;
  esac
}

# Color coded closing function: Sets up borders of farewell message in green, while keeping
Exit(){
	echo
	echo -e "\e[1;92m**********************************************\e[0m";
	echo -e "\e[94m<>\e[0m	\e[1;91mThanks for playing $Name!\e[0m";
	echo -e "\e[94m<>\e[0m	\e[1;91mGoodbye!\e[0m";
	echo -e "\e[1;92m**********************************************\e[0m";
	echo;
}

# Function to erase high scores: Erases high score upon call.
Reset(){
	rm -f /tmp/score.txt;
	echo -e "<>    High score board has been restored.";
}

# Calls every other function and takes full control of the game.
Game(){
	#To see the number for debugging, uncomment the following line
	echo "the random number is $Random"
	# Calls Welcome function and Generates score board.
	Welcome;
	GenerateStats;
	if [[ ! "$Name" ]]; then
		read -p "<>     Enter your name: " Name;
	fi
	echo;
	let tries=1 && Guess;

	if [[ $FirstGuess -eq $Random ]]; then
		 echo -e "\n<>    $Name, You must be very special. You guessed it on your very first try!\n"
		 Calculate && Repeat;
	else
		 let OldGuess=$FirstGuess;
		 echo -e "<>    \e[93mThat was not it! Try again!\e[0;94m";
		 let tries=2 && Guess;

		 for ((tries=2; NewGuess != $Random; ++tries)); do
			 GuessDiff;	# call function GuessDiff to calculate difference between guesses.
			 if [[ $Guess -lt $Random ]]; then
				 echo -e "<>    \e[37mThe number you guessed is too low.\e[0;94m"
				 echo -e "<>    \e[37mTry going up. :)\e[0;94m";
				 Guess;
			 else
				 echo -e "<>    \e[93mThe number you guessed is to high!\e[0;94m"
				 echo -e "<>    \e[93mTry going down. :)\e[0;94m";
				 Guess;
			 fi
		 done;
		 echo -e "\n<>    Hey $Name! You guessed it in $tries tries!\n";
		 Calculate && Repeat;
	 fi
}
### Ending of Functions ###

# Pass option as a command to reset score board.
if [[ "$1" == "-r" ]]; then
	Reset;
fi
# Functions call:
RandomNumber && Game;
