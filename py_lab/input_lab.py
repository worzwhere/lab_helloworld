'''
xstring = input("Enter a number: ")
x = int(xstring)

ystring = input("Enter a second number: ")
y = int(ystring)

print('The sum of ' , x, 'and', y, ' is', x+y)
'''


'''
def name():
    print(xstr)

xstr = input("what is your name ? : ")

name()
#print(x_str)
'''
# global var
    
x = int(input("what is the first number ? : "))
y = int(input("what is the second number ? : "))    

# function

def plus():
    print("the add number is :" , x+y)
    z = int(input("what is the third number ? : "))
    print("the add number is :" , x+y+z)
    
def minus():
    print("the minus number is :" , x-y)

# running command 

plus()
minus()