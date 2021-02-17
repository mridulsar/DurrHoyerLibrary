# Written By Mridul Sarkar
# 2/12/21 4:39 AM


import time
import numpy as np
import qsharp
from qsharp import Result
from QESA import Algorithm_Even, Algorithm_Odd

#https://arxiv.org/pdf/quant-ph/9605034.pdf / https://arxiv.org/pdf/quant-ph/9607014.pdf

class DH(object):

    def __init__(self,table):

        self.table = np.ndarray.flatten(table) 

        self.N= len(self.table)

        self.y = int(np.random.uniform(0,self.N-1))

    def QMSA(self,N,y,table):

        N = self.N

        y = self.y

        t = self.table

        for i in range(N):

            if N // 2 :
                y_prime = Algorithm_Even.simulate(N,y)
                if table[y_prime] < table[y]:
                    y = y_prime

            else: 
                y_prime = Algorithm_Odd.simulate(N,y)
                if table[y_prime] < table[y]:
                    y = y_prime
        if i == N:
            y = 101 # numpys random array only creates random ints between 1 and 100, assuring that even if an array of all 100s this will catch when the program runs too long
        return y                                                      