execute :create_postgis_database
	user "postgres"
	command "createdb -E UTF8 --locale=en_US.utf8 #{node[:postgis][:database_name]}"
	action :run
end

execute :add_postgis_extension do
	user "postgres"
	command "psql -d #{node[:postgis][:database_name]}  -c 'CREATE EXTENSION postgis'"
	not_if "psql -qAt --list | grep '^#{node[:postgis][:template_name]}\|'", :user => 'postgres'
	action :run
end

for extension in ["postgis", "postgis_topology", "fuzzystrmatch", "postgis_tiger_geocoder"] do
	execute "Install #{extension}" do
		user "postgres"
		command "psql -d #{node[:postgis][:database_name]}  -c 'CREATE EXTENSION #{extension}'"
		action :run
	end
end
