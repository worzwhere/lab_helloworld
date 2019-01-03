##################################################################
###  This script for monitor transaction log used on database  ###
###  Create by Nutchjarin B.                                   ###
###  Create Date. 5 Jul 2016                                   ###
##################################################################
#!/usr/bin/ksh


. /THSWTDBS/usr/th_swtad/sqllib/db2profile


LogUsed_Threshold=1

threshold=$LogUsed_Threshold
alert_filename_1=/THSWTDBS/usr/th_swtad/TPN_Log/alert_dba_txn_THSWTDB

log_space_used=$(db2 get snapshot for database on THSWTDB|grep "Log space used by"|awk '{print $9}')

alert_filename=/THSWTDBS/usr/th_swtad/TPN_Log/alert_dba_txn_THSWTDB_$log_space_used

if [ $log_space_used -gt $threshold ]; then
        echo $(date "+%d-%h-%y,%T")",$log_space_used,Transaction log is MORE THAN THRESHOLD($threshold) !!!"
        echo "Alert TXN is MORE THAN THRESHOLD($threshold)" >  $alert_filename
        db2 get snapshot for all databases > /THSWTDBS/usr/th_swtad/TPN_Log/snp_all_db_DIHEDHDB.txt
        APPID=$(cat /THSWTDBS/usr/th_swtad/TPN_Log/snp_all_db_DIHEDHDB.txt|grep "Appl id holding the oldest transaction"|awk '{print $8}')
        db2 get snapshot for application agentid $APPID > /THSWTDBS/usr/th_swtad/TPN_Log/snp_app_id_DIHEDHDB_$APPID.txt
else
        echo $(date "+%d-%h-%y,%T")",$log_space_used"
        test -f $alert_filename_1* && rm -f $alert_filename_1*
fi



