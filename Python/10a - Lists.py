# Lists

thislist = ["apple", "banana", "cherry"]
print(thislist)


# Access items

print(thislist[0]) # output: apple
print(thislist[1]) # output: banana

## Negative indexing

print(thislist[-1]) # output: cherry

## Range of Indexes

thislist = ["apple", "banana", "cherry", "orange", "kiwi", "melon", "mango"]

print(thislist[2:5]) # output: ["cherry", "orange", "kiwi"]
# Item in position 5 is NOT included

print(thislist[:4]) # output: ["apple", "banana", "cherry", "orange"]
print(thislist[2:]) # output: ["cherry", "orange", "kiwi", "melon", "mango"]
# Leaving place with a blank, use the begining or ending item respectively

print(thislist[-4:-1]) # output: ["orange", "kiwi", "melon"]
# Item with index -1 is NOT included


# Change item value

thislist = ["apple", "banana", "cherry"]
thislist[1] = "blackcurrant"
print(thislist) # output: ["apple", "blackcurrant", "cherry"]

# Loop through a list

for item in thislist:
    print(item)

# Check if an item exists

if "banana" in thislist:
    print("Yeah, 'banana' is in the fruits list")
elif "blackcurrant" in thislist:
    print("Nope, 'banana' isn't in the fruits list, but 'blackcurrant' is.") # This is the output in this example
else:
    print("Nope, 'banana' isn't in the fruits list, neither 'blackcurrant'!")

# List lenght

print(len(thislist)) # Output: 3

# Add item

## At the end

thislist.append("banana")
print(thislist)

## At an specified index

thislist.insert(0 ,"orange")
print(thislist)

# Remove item

thislist.remove("")
