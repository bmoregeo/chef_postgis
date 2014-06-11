# PostGIS chef recipe

A chef recipe for creating a posrgres database with postgis extensions installed.

## Dependency

* [PostgreSQL](http://community.opscode.com/cookbooks/postgresql) 

## Attributes

	database_name - The name of the database to be created. Default: postgis
	postgresql_version - The postgresql version installed. Default: 9.3
	postgis_version - The postgis version to be installed. Default: 2.1
	