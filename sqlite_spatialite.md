# SQLite / Spatialite CLI

URL: https://www.sqlite.org/cli.html

##### Show databases

    .databases

##### Show tables

    .tables

Unfortunately the output has multiple columns and is therefore not per se suitable for further processing in scripts. An alternative is:

    sqlite3 out.sqlite '.schema' | grep "CREATE TABLE '" | sed -e "s/^CREATE TABLE '\([^']*\)'.*$/\1/"

##### Show columns

    PRAGMA table_info(my_table);

##### Show rows

    SELECT * FROM my_table;

##### Use timer

    .timer ON
    SELECT * FROM my_table;

##### Leave program

    .quit
