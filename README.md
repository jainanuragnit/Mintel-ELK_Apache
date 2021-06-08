# mintel-elk

PRE-REQUISITES:

1) 4 GB RAM, 2vCPUs, 20 GB disk linux server
2) Intsall docker and docker-compose on that machine.
   a) docker can be install using yum install docker (if its rhel, similiar command can be used for ubuntu)
   b) Please use below link to install docker-compose :
      https://docs.docker.com/compose/install/
3) Install git on the machine (although it comes by default on aws ec2s):
   yum install git
4) Clone the below repo at your required location on the machine
   https://github.com/jainanuragnit/Mintel-ELK_Apache.git
   Note: if you looking to make any changes in the repo then I would recommend to fork this repo in your repository.

DESIGN and IMPLEMENTATION choices:

1) As the requirements is to spin up the complete ELK using docker, So I have used docker-compose to spin up all the 3 components.
2) The latest version is 7.13.1 for ELK but in this case 7.13.0 is being used for the stability purpose.
3) Instead of spinning up each components i.e. ELK inidvidually using docker commands, the better approach is always combine the resources in docker-compose as we can resolve the depedencies of the resoureces as well in the most efficient manner. (using depends_on)
4) Now to bring up the complete ELK using docker-componse,  push the log file to logstash and to create index on the kibana dashboard , "elk.sh" has been created.
5) The reason to create this "elk.sh" file is , user just have to run this script once PRE-REQUISITES are done. And moreover this script can be used with JENKINS for further CI/CD automation.

ELK DESIGN - 

1) Elasticsearch - it is distributed No SQL database which uses JSOn like messages where you can store messages in the form of json across distibuted system where you can scale across indexes.
   a) Customized elasticsearch.yml file has been created which includes security and monitoring.
   b) A volume has been bind with the elasticsearch container so that even if the container is going down the data can be persist.
   c) default ports have been used. 
 
2) Logstatsh - its a framework or a collector which collects data from different sources then stream the data in data processing pipeline onto the elatic search instance, where elastic search is as NOSQL DB and logstash as the streaming component which pushes the log onto the elatic search.
   a) Customized logstash.yml file has been created which defined the username and password for elastic search, for security purpose we can change this username and password.
      username: elastic
      password: changeme
   b) A logstach pipeline has been created using logstash.conf file in which input and output part has been defined.
   c) Default ports of logstash has been used and these above files are binded at required location in docker-componse file.
   
Kibana - It is the UI component which dispalys the data over the elastic search instance.
   a) In kibana.yml file the username , password and the url for elastic search has been defined.
   
docker-compose.yml
   a) Three services elasticsearch, logstash and kibana has been defined
   b) It will build the image if not locally present
   c) A bridge netwrok wwith the elk has been created for the internal communication of the containers.
   d) volumes have been mounted as and when required.
   e) Ports have been defined as per the requirements.
   
Final Steps -

1) Once the PRE-REQUISITES are completed please use the command "bash elk.sh" which will do everthing required as mentioned above.
