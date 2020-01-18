myList = ["Hola", "Don", "Pepito", "Hola", "Don", "José", "Hola", "José", "Don", "Pepito"]

# First Option
temp = []

for item in myList:
    for value in temp:
        if value == item:
            break
    if len(temp) == 0:
        temp.append(item)
    elif value != item:
        temp.append(item)

print("--- First option ---")
print(myList)
print(temp, '\n')

# Second Option
temp = []
match = False

for item in myList:
    for value in temp:
        if value == item:
            match = True
            break
    if match == False:
        match = False
    else:
        temp.append(item)

print("--- Second option ---")
print(myList)
print(temp)
