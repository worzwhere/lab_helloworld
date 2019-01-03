import sys
import os
print (sys.version)
x = 2
print ("x" + str(x))
print(x)
'hello word'

m = input('''
write = w
read = r
appen = a

please select mode : ''')

print("you select " + m)
file = open("d:/py_lab/test.txt", m)
file.write("\n")
word = input("Please insert your words : ")
file.write(word)
file.close()