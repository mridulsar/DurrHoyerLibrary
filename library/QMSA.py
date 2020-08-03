# Written By Mridul Sarkar
# 7/17/20 12:50AM

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

        y_prime = N

        time_limit = (22.5*np.sqrt(N)+1.4*np.log(N)**2)

        while time.clock() < time_limit:    

            for i in range(N):

                while t[y] > t[y_prime]:

                    if N // 2 :

                        y_prime= Algorithm_Even.simulate(N,y)

                    else: 

                        y_prime=Algorithm_Odd.simulate(N,y)

                if t[y_prime] < t[y]:

                    i=0

            y = y_prime 

        return y                                                      