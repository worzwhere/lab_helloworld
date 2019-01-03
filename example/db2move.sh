########################################################################
###  This script use for backup data in database by db2move command  ###
###  Create by Nutchjarin B. 5 Jul 2016                              ###
########################################################################
#!/usr/bin/ksh


. /THSWTDBS/usr/th_swtad/sqllib/db2profile

cd /THSWTDBS/usr/th_swtad/TPN_Log/DB2MOVE

db2 connect to THSWTDB
db2move THSWTDB export

###### Check Log ######

Check_LOG=$(cat EXPORT.out | grep "Disconnecting from database ... successful!" | wc -l)

if [ $Check_LOG -ne 1 ]; then
echo "DB2MOVE Fail"
else
echo "DB2MOVE Completed"
fi
db2 terminate
