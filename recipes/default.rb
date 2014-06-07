execute :create_postgis_database
	user "postgres"
	command "createdb -E UTF8 --locale=en_US.utf8 #{node[:postgis][:database_name]}"
	action :run
end

for extension in ["postgis", "postgis_topology", "fuzzystrmatch", "postgis_tiger_geocoder"] do
	execute "Install #{extension}" do
		user "postgres"
		command "psql -d #{node[:postgis][:database_name]}  -c 'CREATE EXTENSION #{extension}'"
		action :run
	end
end
