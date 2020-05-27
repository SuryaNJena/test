from urllib.request import urlopen,Request
from bs4 import BeautifulSoup
import pandas as pd

url = "http://www.worldometers.info/coronavirus/"

user_agent = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7'
headers={'User-Agent':user_agent,}

req = Request(url,None,headers)
html = urlopen(req)

soup = BeautifulSoup(html, 'lxml')
type(soup)

table=soup.table

c=open("table.html","w+")
c.write(str(table))

df = pd.read_html("./table.html")[0]
print(df)

search = input("Enter Country Name-")

print(df[df["Country,Other"] == search])



