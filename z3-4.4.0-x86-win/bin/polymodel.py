import time
from z3 import *

t = time.process_time()

lower_limit=-638.3529;
upper_limit=637.1059;

X1=lower_limit;
X2=upper_limit;

thres=1e-4; #setting threshold

#for i in xrange(1,11):

#this is used to refine lower limit
while(1):
    limit=(X1+X2)/2;
    print('limit is', limit)

    #x = Real('x')
    #y = Real('y')
    x1 = Real('x1')
    x2 = Real('x2')
    x3 = Real('x3')
    x4 = Real('x4')
    x5 = Real('x5')
    x6 = Real('x6')
    
    s = Solver()
    #s.set("timeout", 500) #5 seconds timeout #if timeout, will return unknown
    #s.add(x**2*y-x*y**2<limit,-1<x,x<5,y<8,-2<y)
    s.add((x1**2*x2*x3*x4 - x1*x2**2*x3*x5)*x6 - (x1**2*x2 - x1*x2**2) < limit)
    s.add(-1<x1,x1<5)
    s.add(-2<x2,x2<8)
    s.add(1-(2**-8)<x3,x3<1+(2**-8))
    s.add(1-(2**-8)<x4,x4<1+(2**-8))
    s.add(1-(2**-8)<x5,x5<1+(2**-8))
    s.add(1-(2**-8)<x6,x6<1+(2**-8))
    checker=s.check()
    print(checker)

    #print(s.model())

    if checker==sat:
        print('sat')
        IL=limit;
        X2=limit;
        
    elif checker==unsat:
        print('unsat')
        X1=limit;
        
    elif checker==unknown:
        print('Timeout has occured')
        X2=limit;


    if(X2-X1<thres):
        break;


L=X1;
X1=L;
X2=upper_limit
print('The new lower limit is ',L,' old lower limit is ',lower_limit)


#this is used to refine the upper limit
while(1):
    limit=(X1+X2)/2;
    print('limit is', limit)

    #x = Real('x')
    #y = Real('y')
    x1 = Real('x1')
    x2 = Real('x2')
    x3 = Real('x3')
    x4 = Real('x4')
    x5 = Real('x5')
    x6 = Real('x6')
    
    s = Solver()
    #s.set("timeout", 500) #5 seconds timeout #if timeout, will return unknown
    #s.add(x**2*y-x*y**2>limit,-1<x,x<5,y<8,-2<y)
    s.add((x1**2*x2*x3*x4 - x1*x2**2*x3*x5)*x6 - (x1**2*x2 - x1*x2**2) > limit)
    s.add(-1<x1,x1<5)
    s.add(-2<x2,x2<8)
    s.add(1-(2**-8)<x3,x3<1+(2**-8))
    s.add(1-(2**-8)<x4,x4<1+(2**-8))
    s.add(1-(2**-8)<x5,x5<1+(2**-8))
    s.add(1-(2**-8)<x6,x6<1+(2**-8))
    checker=s.check()
    print(checker)

    #print(s.model())

    if checker==sat:
        print('sat')
        IU=limit;
        X1=limit;
        
    elif checker==unsat:
        print('unsat')
        X2=limit;
        
    elif checker==unknown:
        print('Timeout has occured')
        X1=limit;


    if(X2-X1<thres):
        break;

U=X2
print('The new lower limit is ',U,' old lower limit is ',upper_limit)
print ('[ ',L,' ',U, ']')
print('Elapsed Time = %.5f second' %(time.process_time() - t))
