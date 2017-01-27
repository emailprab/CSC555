#!/usr/bin/python
import sys
import re, math
from collections import Counter

WORD = re.compile(r'\w+')

def get_cosine(vec1, vec2):
     intersection = set(vec1.keys()) & set(vec2.keys())
     numerator = sum([vec1[x] * vec2[x] for x in intersection])

     sum1 = sum([vec1[x]**2 for x in vec1.keys()])
     sum2 = sum([vec2[x]**2 for x in vec2.keys()])
     denominator = math.sqrt(sum1) * math.sqrt(sum2)

     if not denominator:
        return 0.0
     else:
        return float(numerator) / denominator

def text_to_vector(text):
     words = WORD.findall(text)
     return Counter(words)

fd = open('center1.txt') # One word per line
wordsToCatch = fd.read().split('\n')
fd.close()

for line in sys.stdin:
   
    ln1 = line.rstrip('\n')+ ''
    ln2 = ln1.replace('\n','')
    ln2 = ln2.replace('\t',' ') 
    ln2 = ln2.replace(',',' ')
    ln2 = ln2.replace("'",' ')
    #ln1 = ln1.split(',')
    words = line.split(',')    
    #for word in word:
        #words = ln1.split()
    #    ln = words.append(word)
    #print ln2

    ln = words
    for word in wordsToCatch:
        text1 = ln2 
        text2 = word 
        #print text1,text2
        vector1 = text_to_vector(text1)
        vector2 = text_to_vector(text2)

        cosine = get_cosine(vector1, vector2)

        #print 'Cosine:', cosine
        print '%s\t%f' % (ln2,cosine)
