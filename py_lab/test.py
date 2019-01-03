"""

def add(x, y):
    return x + y

def do_twice(func, x, y):
    return func(func(x, y), func(x, y))

a = int(input("insert first number : "))
b = int(input("insert second number : "))

print(do_twice(add, a, b))

"""

##########################################################

"""
import random

for i in range(5):
    value = random.randint(1, 6)
    print (str("ori : " + (str(value))))
    print (str("plus " + str(i) + " : " + (str(value + i))))
    
"""

########################################################
"""
def func(x):
    res = 0
    for i in range(x):
        res += i
    return res

print(func(4))

"""
#######################################################

"""
import os

file = open('d:/py_lab/test_1.txt', "w")
file.write("This has been written to a file")
file.close()

file = open('d:/py_lab/test_1.txt',"r")
cont = file.read()
print(cont)
file.close()

print(None)

"""
##############################################################
"""
def some_func():
    print("Hi!")

var = some_func()
print(var)
"""
#############################################################

squares = {1: 1, 2: 4, 3: "error", 4: 16,}
squares[8] = 64
squares[3] = 9
print(squares)