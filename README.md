# Build 

 nothing to build here - we use ready images from DockerHub for this task
 by default, we run: 
 adminer:4.8.1 - as a Web application
 postgres:16.3-alpine3.20 - as a DB

# Run

 1. set rights to run for the .sh scripts via commands:

 cd <dir>
 chmod 775 *.sh #in the <dir>, where script is copied

 2. to run: execute the script 
 ./start.sh 
 it creates a network for the Web app and runs WebApp and DB containers
 3. to stop the app: execute the script 
 ./stop.sh

# Development

nothing is here yet

# Test

nothing is here yet