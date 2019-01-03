#######################################################
###                                                 ###
### This script use for keep database information   ###
### Check Table Size, DB Structure, Tablespace size ###
###                                                 ###
#######################################################
#!/usr/bin/ksh

. /THSWTDBS/usr/th_swtad/sqllib/db2profile

DATE_Format=$(date +%Y%m%d)
DATE_Format2=$(date +%Y%m%d_%H%M)

##function _Keep14days
##{
##    find /THSWTDBS/usr/th_swtad/TPN_Log/Keep_TBSize_THSWTDB/ -mtime +14 |grep "THSWTDB_TBSize_*.log" |awk '{print "rm -rf ",$1}'  |sh
##    find /THSWTDBS/usr/th_swtad/TPN_Log/DB_Structure_THSWTDB/ -mtime +14 |grep "THSWTDB_DB_*.ddl" |awk '{print "rm -rf ",$1}'  |sh
##    find /THSWTDBS/usr/th_swtad/TPN_Log/Keep_TBSSize_THSWTDB/ -mtime +14 |grep "THSWTDB_TBS_*.log" |awk '{print "rm -rf ",$1}'  |sh
##}


function _Check_Table_Size
{
### Check Table Size ###

sh /THSWTDBS/usr/th_swtad/TPN_Script/sysproc.admin_get_tab_info.sh

chmod 644 /THSWTDBS/usr/th_swtad/TPN_Log/Keep_TBSize_THSWTDB/THSWTDB_TBSize_${DATE_Format}.log

}

function _GEN_DB_structure
{
### Check Tablespace Size ###

db2look -d THSWTDB -e -x -l > /THSWTDBS/usr/th_swtad/TPN_Log/DB_Structure_THSWTDB/THSWTDB_DB_${DATE_Format}.ddl

chmod 664 /THSWTDBS/usr/th_swtad/TPN_Log/DB_Structure_THSWTDB/THSWTDB_DB_${DATE_Format}.ddl
}

function _Check_Tablespace_Size
{
### Check Tablespace Size ###

perl /THSWTDBS/usr/th_swtad/TPN_Script/tbs_usage.pl THSWTDB > /THSWTDBS/usr/th_swtad/TPN_Log/Keep_TBSSize_THSWTDB/THSWTDB_TBS_${DATE_Format}.log
echo "\n**********************************************************************************\n" >> /THSWTDBS/usr/th_swtad/TPN_Log/Keep_TBSSize_THSWTDB/THSWTDB_TBS_${DATE_Format}.log

chmod 664 /THSWTDBS/usr/th_swtad/TPN_Log/Keep_TBSSize_THSWTDB/THSWTDB_TBS_${DATE_Format}.log
}


###_Keep14days
_Check_Table_Size
_GEN_DB_structure
_Check_Tablespace_Size

