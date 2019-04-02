from z3 import *

lower_limit=-370;
upper_limit=264;

X1=lower_limit;
X2=upper_limit;

thres=3; #setting threshold

#for i in xrange(1,11):

#this is used to refine lower limit
while(1):
    limit=(X1+X2)/2;
    print('limit is', limit)

    x = Real('x')
    y = Real('y')
    s = Solver()
    s.set("timeout", 500) #5 seconds timeout #if timeout, will return unknown
    s.add(x**2*y-x*y**2<limit,-1<x,x<5,y<8,-2<y)
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

    x = Real('x')
    y = Real('y')
    s = Solver()
    s.set("timeout", 500) #5 seconds timeout #if timeout, will return unknown
    s.add(x**2*y-x*y**2>limit,-1<x,x<5,y<8,-2<y)
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
