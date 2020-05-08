def my_yield(i):
    while i:
        yield i
        i -= 1

def myiel(k):
    t = k*k
    while k < t:
        yield k
        k += k
    print("me queme")


for p in myiel(7):
    print(p)
for p in myiel(3):
    print("beepee")

print("end")
