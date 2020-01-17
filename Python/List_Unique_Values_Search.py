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
match = 0

for item in myList:
    for value in temp:
        if value == item:
            match = 1
            break
    if match == 1:
        match = 0
    else:
        temp.append(item)

print("--- Second option ---")
print(myList)
print(temp)
