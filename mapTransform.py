#!/usr/bin/python 
import sys 
for line in sys.stdin:     
    vals = line.strip().split("|")     
    print "%s\t%s" % (vals[0], ','.join(vals[1:])) 
