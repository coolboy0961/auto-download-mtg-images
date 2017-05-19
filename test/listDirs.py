import os
import re

files = os.listdir("/Users/coolboy096188/Library/Caches/Forge/pics/cards")
str = ""
for file in files:
    str += file.lower() + ","
print(str)

str2 = "ab"
str2 = str2.replace("/", ":")
print(str2)


#pattern = "[A-Za-Z]+ \(([A-Za-Z]+)/([A-Za-Z]+)\)"
pattern = "^[a-zA-Z]+ \(([a-zA-Z]+.*)/([a-zA-Z]+.*)\)"
text = "Rags (Rags abc/Riches bbb)"
repatter = re.compile(pattern)
matchOB = repatter.match(text)
if matchOB:
    print matchOB.group(0)
    print matchOB.group(1)
    print matchOB.group(2)
    print matchOB.group(1) + matchOB.group(2)
