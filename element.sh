#!/bin/bash

PSQL="psql -U freecodecamp -d periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo -e "\033[31mPlease provide an element as an argument.\033[0m"
  exit
fi

# If you run ./element.sh 1, ./element.sh H, or ./element.sh Hydrogen, gets an output with element details
if [[ $1 && ($1 =~ ^[a-zA-Z]+$ || $1 =~ ^[0-9]+$) ]]; then
  if [[ $1 =~ ^[A-Z]?[a-zA-Z]$ ]]; then
      QUERY_INPUT="WHERE symbol='$1'"

    elif [[ $1 =~ ^[a-zA-Z]+$ ]]; then
      QUERY_INPUT="WHERE name ILIKE '$1'"

    else
      QUERY_INPUT="WHERE atomic_number = $1"
  fi
    
  QUERY_RESULT="$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius
    FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) $QUERY_INPUT")"

  if [[ -z $QUERY_RESULT ]]; then
      echo -e "\033[33mI could not find that element in the database.\033[0m\n"
      exit
  fi

  echo $QUERY_RESULT | while IFS='|' read ATOMIC_NUMBER  NAME  SYMBOL  TYPE  ATOMIC_MASS  MELTING_POINT  BOILING_POINT; do
    echo -e "\n The element with atomic number \033[32m$ATOMIC_NUMBER\033[0m is \033[32m$NAME\033[0m (\033[32m$SYMBOL\033[0m).\n It's a \033[32m$TYPE\033[0m, with a mass of \033[32m$ATOMIC_MASS\033[0m amu.\n "$NAME" has a melting point of \033[32m$MELTING_POINT\033[0m celsius and a boiling point of \033[32m$BOILING_POINT\033[0m celsius.\n"
  done

fi
