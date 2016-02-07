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

##### Show geometries as WKT

    SELECT AsText(geometry) FROM my_table;

## Do some work

##### Rename table

    ALTER TABLE 'oldname' RENAME TO 'newname';

## Spatial indices

Based on: https://www.gaia-gis.it/gaia-sins/spatialite-cookbook/html/rtree.html

There are two kinds of spatial indices:

- R*Tree (current)
- MBR (deprecated)

### Create R*Tree index

    BEGIN; SELECT CreateSpatialIndex('mytable', 'GEOMETRY'); COMMIT;

### Determine if R*Tree index was written

Look out for the following tables:

- `idx_mytable_GEOMETRY`
- `idx_mytable_GEOMETRY_node`
- `idx_mytable_GEOMETRY_parent`
- `idx_mytable_GEOMETRY_rowid`

### Profiting from a R*Tree index

Unfortunately, queries need to be restructured to profit from indices.

Links:
- https://www.gaia-gis.it/fossil/libspatialite/wiki?name=SpatialIndex
- https://www.gaia-gis.it/gaia-sins/spatialite-tutorial-2.3.1.html (section 8)

(This section needs to be expanded.)

## Other

##### Use timer

    .timer ON
    SELECT * FROM my_table;

##### Leave program

    .quit
