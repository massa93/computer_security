import sys

def pr(m):
	sys.stdout.write(m)

def caesar(m,n):
	#print ("trs: "+m)
	c = ""
	for i in range(0, len(m)-1):
		tmp = m[i]
		for j in range(0, int(n)):
			if tmp == "z":
				tmp = "a"
			elif tmp == " ":
				tmp = " "
			else:
				tmp = chr(ord(tmp) + 1)
		c = c + tmp
	return c	

msg = "ufdvm pt r gjck ery oc rofcf o kpfr"
#msg = "h yaeolvnleeor"
#msg = sys.argv[1]
l = len (msg)
#print (l)

for my in range(1, l):
	mx =int( l / my + 1)
	#print mx
	#print my
	tr = ""
	for y in range (0, int(my)):
		#print 'x=',x
		for x in range (0, int(mx)):
			#print 'y=',y
			e = x*my+y
			if e<l:
				#print e
				#pr(msg[e])
				tr = tr + msg[e]
	pr(tr)
	print (' // X= ',mx,' Y=',my)
	for i in range(1, 26):
		#print ("transl: "+tr)
		print ("    " + caesar(tr,i)+ " #Caesar "+str(i))