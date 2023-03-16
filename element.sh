#!/bin/bash

PSQL="psql -U freecodecamp -d periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
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
      echo "I could not find that element in the database."
      exit
  fi

  echo $QUERY_RESULT | while IFS='|' read ATOMIC_NUMBER  NAME  SYMBOL  TYPE  ATOMIC_MASS  MELTING_POINT  BOILING_POINT; do
    echo "The element with atomic number "$ATOMIC_NUMBER" is "$NAME" ("$SYMBOL"). It's a "$TYPE", with a mass of "$ATOMIC_MASS" amu. "$NAME" has a melting point of "$MELTING_POINT" celsius and a boiling point of "$BOILING_POINT" celsius."
  done

fi
