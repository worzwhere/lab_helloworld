case "$1" in
        start)
            start
            ;;
         
        stop)
            stop
            ;;
         
        status)
            status anacron
            ;;
        restart)
            stop
            start
            ;;
        condrestart)
            if test "x`pidof anacron`" != x; then
                stop
                start
            fi
            ;;
         
        *)
            echo $"Usage: $0 {start|stop|restart|condrestart|status}"
            exit 1
 
esac


##############################################

read -p "select the number [1 - 3] : " num
case "$num" in
        1)
            echo "You select number 1"
            ;;
         
        2)
            echo "You select number 2"
            ;;
         
        3)
            echo "You select number 3"
            ;;
			
esac

echo "End of program"