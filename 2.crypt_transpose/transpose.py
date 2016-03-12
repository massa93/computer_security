import sys

def pr(m):
	sys.stdout.write(m)

#msg = "ufdvm pt r gjck ery oc rofcf o kpfr"
#msg = "h yaeolvnleeor"
msg = sys.argv[1]
l = len (msg)
#print (l)

for my in range(1, l):
	mx = l / my + 1
	#print mx
	#print my
	for y in range (0, my):
		#print 'x=',x
		for x in range (0, mx):
			#print 'y=',y
			e = x*my+y
			if e<l:
				#print e
				pr(msg[e])
	print ' // X= ',mx,' Y=',my
 
