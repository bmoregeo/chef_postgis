package "postgresql-#{node[:postgis][:postgresql_version]}-postgis-#{node[:postgis][:postgis_version]}"

execute :create_postgis_database do
	user "postgres"
	command "createdb #{node[:postgis][:database_name]} -E UTF8"
	action :run
	not_if "psql -qAt --list | grep '^#{node['postgis']['database_name']}\|'", user: "postgres"
end

for extension in ["postgis", "postgis_topology", "fuzzystrmatch", "postgis_tiger_geocoder"] do
	execute "Drop #{extension}" do
		user "postgres"
		command "psql -d #{node[:postgis][:database_name]}  -c 'DROP EXTENSION IF EXISTS #{extension}'"
		action :run
	end
	execute "Install #{extension}" do
		user "postgres"
		command "psql -d #{node[:postgis][:database_name]}  -c 'CREATE EXTENSION #{extension}'"
		action :run
	end
end
