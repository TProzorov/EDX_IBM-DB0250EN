# The first lab for EDX_IBM DB0250EN

# This script
# Extracts data from "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz".

# The following are the columns and their data types in the file:
# a. timestamp - TIMESTAMP
# b. latitude - float
# c. longitude - float
# d. visitorid - char(37)
# and two more columns: accessedfrommobile (boolean) and browser_code (int)

#The columns which we need to copy to the table are the first four coumns : timestamp, latitude, longitude and visitorid.

# Create the table.
# echo "\c template1;\\create table access_log(timestamp TIMESTAMP, latitude float, longitude float, visitorid char(37));" | psql --username=postgres --host=localhost

# Extract
echo 'Extract data'
wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"

gunzip -f web-server-access-log.txt.gz

cut -d# -f1-4 web-server-access-log.txt > extracted_data.csv 

# Load
echo 'Load data'
echo "\c template1;\COPY access_log  FROM '/home/project/extracted_data.csv' DELIMITERS '#' csv HEADER;" | psql --username=postgres --host=localhost

# check
echo "\c template1;\select * from access_log;" | psql --username=postgres --host=localhost