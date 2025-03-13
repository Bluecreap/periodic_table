
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only  -c"

if [[ -z $1 ]]
then 
  echo -e "Please provide an element as an argument."
else
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties LEFT JOIN elements USING(atomic_number) LEFT JOIN types USING(type_id) WHERE name = '$1' OR symbol = '$1';")
  else
    ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties LEFT JOIN elements USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number = $1;")
  fi
  if [[ -z $ELEMENT ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$ELEMENT" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR AMASS BAR MELT BAR BOIL
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AMASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done
  fi
fi
