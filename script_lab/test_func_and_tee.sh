 #!/bin/bash 
 
 cat << "EOF"
 _          _ _               _           _
| |__   ___| | |   ___     __| |_   _  __| | ___
| '_ \ / _ \ | |  / _ \   / _` | | | |/ _` |/ _ \
| | | |  __/ | | | (_) | | (_| | |_| | (_| |  __/
|_| |_|\___|_|_|  \___/   \__,_|\__,_|\__,_|\___|

EOF

# insert words between "EOF" and EOF
####################################################
echo
echo "L0gg!ng on pr0duct!0n s3rv3r"
echo
####################################################

 log=/d/script_lab/log_func_$(date +'%d%m%Y').txt
 
			function list {
			   ls -lart
           }
		   
		   function _df {
			   df -h
           }
 
			function hi {
			   echo "Function hi"
               echo "comeon"
			   echo "hi"
           }
		   
           function quit {
               exit
           }
		   
           function hello {
			   echo "Function hello"
               echo "Hello!"
           }

		   function _grep_556 {
			   cat $log |grep --color 566
           }
		   
		   function _grep_df {
			   cat $log |grep --color '/d'
			   cat $log |grep --color 'Git'
			}
		   
####################################################
		   
list | tee -a $log
_df | tee -a $log
echo | tee -a $log
hi | tee -a $log
echo| tee -a $log
hello| tee -a $log
echo "completed" | tee -a $log
echo "grep"
_grep_556
_grep_df

#quit