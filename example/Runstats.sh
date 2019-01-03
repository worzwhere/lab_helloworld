########################################################################
###                                                                  ###
###  This script use for runstats on application tables in database  ###
###                                                                  ###
########################################################################
#!/usr/bin/ksh

. /THSWTDBS/usr/th_swtad/sqllib/db2profile

DBNAME=THSWTDB
ScrPath=/THSWTDBS/usr/th_swtad/TPN_Script/
LogPath=/THSWTDBS/usr/th_swtad/TPN_Log/  
DATE_Format=$(date +%Y%m%d_%H%M)
DATE_Format2=$(date +%Y%m%d)
LogName_Format=${DBNAME}_Runstat_${DATE_Format}.log
ErrName_Format=${DBNAME}_Runstat_${DATE_Format}.err
ScrName_Format=${DBNAME}_Runstat_${DATE_Format2}.sql 
usage () {
echo "Usage: Runstat.sh   " 
echo "   Ex: Runstat.sh   "
exit
}

function _dbConnect
{
	db2 connect to ${DBNAME}
}

function _dbDisconnect
{
	db2 -v connect reset
	db2 -v terminate
}

function _GenScr_runstat
{
db2 -x "select 'db2 -v \"RUNSTATS ON TABLE TH_SWTDB.'||tabname ||' WITH DISTRIBUTION ON ALL COLUMNS AND SAMPLED DETAILED INDEXES ALL TABLESAMPLE BERNOULLI(35)\"' from syscat.tables where tabschema = 'TH_SWTDB' and  type = 'T'"
}

function _Keep21days
{
       find /THSWTDBS/usr/th_swtad/TPN_Script/ -mtime +21 |grep "THSWTDB_Runstat_" |awk '{print "rm -f ",$1}'  |sh
       find /THSWTDBS/usr/th_swtad/TPN_Log/Logs/ -mtime +21 |grep "THSWTDB_Runstat_" |awk '{print "rm -f ",$1}'  |sh
}


# Start Execute script
>${LogPath}${LogName_Format}
echo "Starting excute runstats ">>${LogPath}${LogName_Format}
date >>${LogPath}${LogName_Format}
_dbConnect >>${LogPath}${LogName_Format}
echo "#!/usr/bin/ksh" > ${ScrPath}${ScrName_Format} 
echo ". /THSWTDBS/usr/th_swtad/sqllib/db2profile" >> ${ScrPath}${ScrName_Format} 

echo "db2 connect to ${DBNAME}" >> ${ScrPath}${ScrName_Format}
_GenScr_runstat >>${ScrPath}${ScrName_Format}
echo "db2 terminate" >>${ScrPath}${ScrName_Format}
cd ${ScrPath}
chmod 744  ./${ScrName_Format}  >>${LogPath}${LogName_Format}
chmod +x ./${ScrName_Format}  >>${LogPath}${LogName_Format}
./${ScrName_Format}  >>${LogPath}${LogName_Format}
_dbDisconnect >>${LogPath}${LogName_Format}
echo "End excute runstats ">>${LogPath}${LogName_Format}
date >>${LogPath}${LogName_Format}
chmod 744 ${LogPath}${LogName_Format}

_Keep21days


