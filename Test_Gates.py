import qsharp
from QMSA import Algorithm_Odd, Algorithm_Even, S_A, S_0, Controlled_Not
from preprocess import information
t =[10,4,8,2,9,7,1]
q = information(t)
def Test_CNOT():
    if S_A(q) == Controlled_Not(q):
        print(S_A(q))
        print(Controlled_Not(q))
        return True
    else:
        return False
Test_CNOT()
