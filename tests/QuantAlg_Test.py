# Written By Mridul Sarkar
# 6/6/20 2:43 AM

from DurrandHoyer import DH
import numpy as np
table = np.array([1,2,3,4])

test = DH(table)

output = test.algorithm()
truths=[]
lies=[]
for i in range(100):
    if table(output) == min(table):
        truths=truths.append(True)
    else:
        lies = lies.append(False)

return len(truths),len(lies)
print('Should be 50/50')