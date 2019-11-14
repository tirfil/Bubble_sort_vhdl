
import random

asort = []
arand = []

for i in range(256):
	asort.append(i)
	
for i in range(256):
	last = 255-i
	val = random.randint(0,last)
	arand.append(asort[val])
	if (val != last):
		asort[val] = asort[last]
		
for i in range(256):
	print ("%d=>x\"%02x\","%(i,arand[i]))
	
