# SQLite / Spatialite CLI

URL: https://www.sqlite.org/cli.html

## Get (meta) information

##### Show databases

    .databases

##### Show tables

    .tables

Unfortunately the output has multiple columns and is therefore not per se suitable for further processing in scripts. An alternative is:

    sqlite3 out.sqlite '.schema' | grep "CREATE TABLE '" | sed -e "s/^CREATE TABLE '\([^']*\)'.*$/\1/"

##### Show columns

    PRAGMA table_info(my_table);

and for attached databases:

    PRAGMA my_db_alias.table_info(my_table);

##### Show rows

    SELECT * FROM my_table;

## Do some work

##### Rename table

ALTER TABLE 'oldname' RENAME TO 'newname';

## Other

##### Use timer

    .timer ON
    SELECT * FROM my_table;

##### Leave program

    .quit
