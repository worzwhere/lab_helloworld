ls -lart
read -p "type \"YES\" to do a delete job : " yes
echo 'You replied with' \"$yes\"
touch test_del.txt

	case "$yes" in
	
		YES)
  			ls -lart *.txt
			rm -f *.txt
			ls -lart
			echo
			echo "All log \".txt\" have been deleted" 
			;;
	
		*)
			echo
			echo "The Job has been cancel"
			;;
	esac
