x = "NO"
while x == "YES":
    x = str(input("Please type "+"YES" +": " ))
    while x == "YES":
        print("That is all right : " + (x))
        break
    else:
        print("Wrong")