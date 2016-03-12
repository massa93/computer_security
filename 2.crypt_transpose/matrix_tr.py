from __future__ import print_function
import sys

def pr(m):
        sys.stdout.write(m)

msg = "ufdvm pt r gjck ery oc rofcf o kpfr"
l = len (msg)

i = 0

for my in range (2, l):
	print
	mx = l / my + 1
	m = [[0 for x in range(my)] for x in range(mx)]
	i = 0
	for x in range (0,mx):
		for y in range (0,my):
			if i<l:
				m[x][y]= msg[i]
			i = i + 1
	#print m
	for y in range (0,my):
		for x in range (0,mx):
			if not m[x][y]==0:
        			print (m[x][y], end='')
	print (' // X,Y= ', mx, my)

		

	

