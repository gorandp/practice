# The while loop requires relevant variables to be ready,
# in this example we need to define an indexing variable,
# i, which we set to 1.
i = 1
while i < 6:
    print(i)
    i += 1
print()

# With the break statement we can stop the loop even if the
# while condition is true:
print(">>>> Break statement <<<<")
i = 1
while i < 6:
    print(i)
    if (i == 3):
        break
    i += 1
print()

# NEW <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

# The continue statement
# With the continue statement we can stop the current iteration, and continue with the next:
print(">NEW>>> The continue statement <<<<")
i = 0
while i < 6:
    i += 1
    if i == 3:
        continue
    print(i)
print("Skipped print(i) when i == 3\n")

# The else statement
# With the else statement we can run a block of code once when the condition no longer is true:
print(">NEW>>> The else statement <<<<")
i = 1
while i < 6:
    print(i)
    i += 1
else:
    print("i is no longer less than 6")
