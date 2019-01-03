
i = int(input("please insert number : "))
while True:
    i = i +1
    if i == 2:
        print("Skipping 2")
        continue
    if i == 5:
        print("Breaking")
        continue
    if i >= 100:
        print("Ended")
        break    
    print(i)

print("Finished")