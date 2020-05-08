import requests
from bs4 import BeautifulSoup

f = open("Python/xml/rssexample", 'r')
root = BeautifulSoup(f, features='xml')

for item in root.findAll("item"):
    print(item)
    print(item.text) # Don't include tags

print("Finish")