# Periodic Table Database & Bash Script Project

This project through the Bash script, does differents queries to the database (PostgreSQL) using JOINs to relate table and display to the user the properties for an specific element of the periodic table.

## Database Tables

![Alt text](/public/periodic-db-details.webp)


### Elements Table

![Alt text](/public/elements.webp)


### Types Table

![Alt text](/public/types.webp)


### Properties Table

![Alt text](/public/properties.webp)


## Bash Script

The Bash script interacts with the periodic table database and performs tasks such as JOIN tables to display the element details. Here is the commands and its output:<br>

- Enter `./periodict-table.sh` command with an argument like the `Symbol`, `Name` or its `Atomic number` in the bash terminal to run the script and query the properties of the element.<br>
Example: `./periodict-table.sh` + `H` ---> It returns the Hydrogen properties.

#### Part 1
![Alt text](/public/result.webp)


## Conclusion

This salon database project demonstrates the use of PostgreSQL for storing and managing data. Also, the hability to relate differents table according to its primary and foreign keys.
