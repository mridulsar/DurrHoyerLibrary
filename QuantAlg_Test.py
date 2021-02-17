# Written By Mridul Sarkar
# 6/6/20 2:43 AM

from QMSA import DH
import numpy as np
from numpy import random
class tests(object):
    def __init__(self,even,odd):
        print('enter even number for array size')
        self.n = input()
        print('enter odd number for array size')
        self.m = input()

    def Even_Test(self,n):
        n = self.n
        table_even = random.randint(n)
        test = DH(table_even)

        output = test.Algorithm_Even()
        truths=[]
        lies=[]
        for i in range(100):
            if table_even(output) == min(table_even):
                truths=truths.append(True)
            else:
                lies = lies.append(False)
        if abs(len(truths)-len(lies)) <= 10:
            print('acceptable error')
            return 0
        elif abs(len(truths)-len(lies)) == 0:
            return 0
        else:
            return 1

    def Odd_Test(self,m):
        m = m.self
        table_odd = random.randint(m)
        test = DH(table_odd)

        output = test.Algorithm_Odd()
        truths=[]
        lies=[]
        for i in range(100):
            if table_odd(output) == min(table_odd):
                truths=truths.append(True)
            else:
                lies = lies.append(False)
        if abs(len(truths)-len(lies)) <= 10:
            print('acceptable error')
            return 0
        elif abs(len(truths)-len(lies)) == 0:
            print('amazing job')
            return 0
        else:
            return 1
    def Complexity_Test(self,iterations,n,m):
        if np.log(iterations)<=np.log(n) & np.log(iterations)<=np.log(m):
            return 0
        else:
            return 1