#!/bin/bash
# ----  
# The section to define script's vars
network_name=normal01
network=192.168.0.0/28
ip_webapp=192.168.0.2
ip_db=192.168.0.4

webapp_inst_name=webapp

db_inst_name=dbase02
db_parameter=POSTGRES_PASSWORD
db_parameter_value=123
# The dir at a host wich is supposed to keep DBs files. 
# Assumed to be placed in the directory from where this script is run
db_dir_local=postgres/data
# Edit this line cautiously - this is mapping to container's dir. 
# Ensure you placed correct line here - mind your step!
db_dir_where_to_pass=var/lib/postgresql/data

# Images for the app and db to use in the installation.
webapp_docker_image=adminer:4.8.1
db_docker_image=postgres:16.3-alpine3.20
# ----

# The main section

# Check if the dir db_dir_local exists in dir where the script is run
# Assumed to be placed in the directory from where this script is run
dir_to_check=$(pwd)/$db_dir_local
if  [ -d $dir_to_check ]
then 
echo "The $dir_to_check for the container's DB files already exists, We don't need to do something here."
else 
mkdir -p $db_dir_local
echo "The $dir_to_check for the database' files has been created. Probably, this it is the run from scratch of this app here?"
fi

# creation of the specific Docker network for the WebApp and DB is here
docker network create --subnet $network $network_name

# creation of the DB container here
# db files are placed at the path  $(pwd)/$db_dir_local 

# for debug
#docker run --net normal01 --ip 192.168.0.3  --rm  --name dbase -d -e MYSQL_ROOT_PASSWORD=123 -v /home/astra/mysql02:/var/lib/mysql mysql:8.0.38-bookworm

docker run --net $network_name --ip $ip_db  --rm  --name $db_inst_name --hostname $db_inst_name -d -e $db_parameter=$db_parameter_value -v $(pwd)/$db_dir_local:/$db_dir_where_to_pass $db_docker_image
echo  "The DB $db_docker_image is started!"


# creation of the Web application container
docker run --net $network_name --ip $ip_webapp --rm --name $webapp_inst_name --hostname $webapp_inst_name $webapp_docker_image
echo "The app $webapp_docker_image is started!"
