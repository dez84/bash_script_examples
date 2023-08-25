#!/bin/bash
db_user="username"
db_password="password"
db_name="database_name"
backup_filename="backup_$(date +"%Y%m%d%H%M%S").sql"

mysqldump -u $db_user -p$db_password $db_name > "$backup_filename"
scp "$backup_filename" user@remote_server:/path/to/destination/

