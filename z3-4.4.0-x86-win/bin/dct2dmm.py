import time
from z3 import *

t = time.process_time()

lower_limit=0.000000000000000e+000;
upper_limit=5.039138793945317e+000;

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
    d1 = Real('d1')
    d2 = Real('d2')
    d3 = Real('d3')
    d4 = Real('d4')
    d5 = Real('d5')
    d6 = Real('d6')
    d7 = Real('d7')
    d8 = Real('d8')
    d9 = Real('d9')
    d10 = Real('d10')
    d11 = Real('d11')
    d12 = Real('d12')
    d13 = Real('d13')
    d14 = Real('d14')
    d15 = Real('d15')
    d16 = Real('d16')
    d17 = Real('d17')
    d18 = Real('d18')
    d19 = Real('d19')
    d20 = Real('d20')
    d21 = Real('d21')
    d22 = Real('d22')
    d23 = Real('d23')
    d24 = Real('d24')
    d25 = Real('d25')
    x26 = Real('x26')
    x27 = Real('x27')
    x28 = Real('x28')
    x29 = Real('x29')
    x30 = Real('x30')
    x31 = Real('x31')
    x32 = Real('x32')
    x33 = Real('x33')
    x34 = Real('x34')
    x35 = Real('x35')
    x36 = Real('x36')
    x37 = Real('x37')
    x38 = Real('x38')
    x39 = Real('x39')
    x40 = Real('x40')
    x41 = Real('x41')
    x42 = Real('x42')
    x43 = Real('x43')
    x44 = Real('x44')
    x45 = Real('x45')
    x46 = Real('x46')
    x47 = Real('x47')
    x48 = Real('x48')
    x49 = Real('x49')
    x50 = Real('x50')
    
    s = Solver()
    #s.set("timeout", 500) #5 seconds timeout #if timeout, will return unknown
    #s.add(x**2*y-x*y**2<limit,-1<x,x<5,y<8,-2<y)
    s.add((5**(1.0/2)*d1*((5**(1.0/2)*d1*x26)/5.0 + (5**(1.0/2)*d2*x31)/5.0 + (5**(1.0/2)*d3*x36)/5.0 + (5**(1.0/2)*d4*x41)/5.0 + (5**(1.0/2)*d5*x46)/5.0))/5.0 + (5**(1.0/2)*d2*((5**(1.0/2)*d1*x27)/5.0 + (5**(1.0/2)*d2*x32)/5.0 + (5**(1.0/2)*d3*x37)/5.0 + (5**(1.0/2)*d4*x42)/5.0 + (5**(1.0/2)*d5*x47)/5.0))/5.0 + (5**(1.0/2)*d3*((5**(1.0/2)*d1*x28)/5.0 + (5**(1.0/2)*d2*x33)/5.0 + (5**(1.0/2)*d3*x38)/5.0 + (5**(1.0/2)*d4*x43)/5.0 + (5**(1.0/2)*d5*x48)/5.0))/5.0 + (5**(1.0/2)*d4*((5**(1.0/2)*d1*x29)/5.0 + (5**(1.0/2)*d2*x34)/5.0 + (5**(1.0/2)*d3*x39)/5.0 + (5**(1.0/2)*d4*x44)/5.0 + (5**(1.0/2)*d5*x49)/5.0))/5.0 + (5**(1.0/2)*d5*((5**(1.0/2)*d1*x30)/5.0 + (5**(1.0/2)*d2*x35)/5.0 + (5**(1.0/2)*d3*x40)/5.0 + (5**(1.0/2)*d4*x45)/5.0 + (5**(1.0/2)*d5*x50)/5.0))/5.0 < limit)
    s.add(1-(2**-8)<d1,d1<1+(2**-8))
    s.add(1-(2**-8)<d2,d2<1+(2**-8))
    s.add(1-(2**-8)<d3,d3<1+(2**-8))
    s.add(1-(2**-8)<d4,d4<1+(2**-8))
    s.add(1-(2**-8)<d5,d5<1+(2**-8))
    s.add(1-(2**-8)<d6,d6<1+(2**-8))
    s.add(1-(2**-8)<d7,d7<1+(2**-8))
    s.add(1-(2**-8)<d8,d8<1+(2**-8))
    s.add(1-(2**-8)<d9,d9<1+(2**-8))
    s.add(1-(2**-8)<d10,d10<1+(2**-8))
    s.add(1-(2**-8)<d11,d11<1+(2**-8))
    s.add(1-(2**-8)<d12,d12<1+(2**-8))
    s.add(1-(2**-8)<d13,d13<1+(2**-8))
    s.add(1-(2**-8)<d14,d14<1+(2**-8))
    s.add(1-(2**-8)<d15,d15<1+(2**-8))
    s.add(1-(2**-8)<d16,d16<1+(2**-8))
    s.add(1-(2**-8)<d17,d17<1+(2**-8))
    s.add(1-(2**-8)<d18,d18<1+(2**-8))
    s.add(1-(2**-8)<d19,d19<1+(2**-8))
    s.add(1-(2**-8)<d20,d20<1+(2**-8))
    s.add(1-(2**-8)<d21,d21<1+(2**-8))
    s.add(1-(2**-8)<d22,d22<1+(2**-8))
    s.add(1-(2**-8)<d23,d23<1+(2**-8))
    s.add(1-(2**-8)<d24,d24<1+(2**-8))
    s.add(1-(2**-8)<d25,d25<1+(2**-8))
    s.add(0<x26,x26<1)
    s.add(0<x27,x27<1)
    s.add(0<x28,x28<1)
    s.add(0<x29,x29<1)
    s.add(0<x30,x30<1)
    s.add(0<x31,x31<1)
    s.add(0<x32,x32<1)
    s.add(0<x33,x33<1)
    s.add(0<x34,x34<1)
    s.add(0<x35,x35<1)
    s.add(0<x36,x36<1)
    s.add(0<x37,x37<1)
    s.add(0<x38,x38<1)
    s.add(0<x39,x39<1)
    s.add(0<x40,x40<1)
    s.add(0<x41,x41<1)
    s.add(0<x42,x42<1)
    s.add(0<x43,x43<1)
    s.add(0<x44,x44<1)
    s.add(0<x45,x45<1)
    s.add(0<x46,x46<1)
    s.add(0<x47,x47<1)
    s.add(0<x48,x48<1)
    s.add(0<x49,x49<1)
    s.add(0<x50,x50<1)
    
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
    d1 = Real('d1')
    d2 = Real('d2')
    d3 = Real('d3')
    d4 = Real('d4')
    d5 = Real('d5')
    d6 = Real('d6')
    d7 = Real('d7')
    d8 = Real('d8')
    d9 = Real('d9')
    d10 = Real('d10')
    d11 = Real('d11')
    d12 = Real('d12')
    d13 = Real('d13')
    d14 = Real('d14')
    d15 = Real('d15')
    d16 = Real('d16')
    d17 = Real('d17')
    d18 = Real('d18')
    d19 = Real('d19')
    d20 = Real('d20')
    d21 = Real('d21')
    d22 = Real('d22')
    d23 = Real('d23')
    d24 = Real('d24')
    d25 = Real('d25')
    x26 = Real('x26')
    x27 = Real('x27')
    x28 = Real('x28')
    x29 = Real('x29')
    x30 = Real('x30')
    x31 = Real('x31')
    x32 = Real('x32')
    x33 = Real('x33')
    x34 = Real('x34')
    x35 = Real('x35')
    x36 = Real('x36')
    x37 = Real('x37')
    x38 = Real('x38')
    x39 = Real('x39')
    x40 = Real('x40')
    x41 = Real('x41')
    x42 = Real('x42')
    x43 = Real('x43')
    x44 = Real('x44')
    x45 = Real('x45')
    x46 = Real('x46')
    x47 = Real('x47')
    x48 = Real('x48')
    x49 = Real('x49')
    x50 = Real('x50')
    
    s = Solver()
    #s.set("timeout", 500) #5 seconds timeout #if timeout, will return unknown
    #s.add(x**2*y-x*y**2>limit,-1<x,x<5,y<8,-2<y)
    s.add((5**(1.0/2)*d1*((5**(1.0/2)*d1*x26)/5.0 + (5**(1.0/2)*d2*x31)/5.0 + (5**(1.0/2)*d3*x36)/5.0 + (5**(1.0/2)*d4*x41)/5.0 + (5**(1.0/2)*d5*x46)/5.0))/5.0 + (5**(1.0/2)*d2*((5**(1.0/2)*d1*x27)/5.0 + (5**(1.0/2)*d2*x32)/5.0 + (5**(1.0/2)*d3*x37)/5.0 + (5**(1.0/2)*d4*x42)/5.0 + (5**(1.0/2)*d5*x47)/5.0))/5.0 + (5**(1.0/2)*d3*((5**(1.0/2)*d1*x28)/5.0 + (5**(1.0/2)*d2*x33)/5.0 + (5**(1.0/2)*d3*x38)/5.0 + (5**(1.0/2)*d4*x43)/5.0 + (5**(1.0/2)*d5*x48)/5.0))/5.0 + (5**(1.0/2)*d4*((5**(1.0/2)*d1*x29)/5.0 + (5**(1.0/2)*d2*x34)/5.0 + (5**(1.0/2)*d3*x39)/5.0 + (5**(1.0/2)*d4*x44)/5.0 + (5**(1.0/2)*d5*x49)/5.0))/5.0 + (5**(1.0/2)*d5*((5**(1.0/2)*d1*x30)/5.0 + (5**(1.0/2)*d2*x35)/5.0 + (5**(1.0/2)*d3*x40)/5.0 + (5**(1.0/2)*d4*x45)/5.0 + (5**(1.0/2)*d5*x50)/5.0))/5.0 > limit)
    s.add(1-(2**-8)<d1,d1<1+(2**-8))
    s.add(1-(2**-8)<d2,d2<1+(2**-8))
    s.add(1-(2**-8)<d3,d3<1+(2**-8))
    s.add(1-(2**-8)<d4,d4<1+(2**-8))
    s.add(1-(2**-8)<d5,d5<1+(2**-8))
    s.add(1-(2**-8)<d6,d6<1+(2**-8))
    s.add(1-(2**-8)<d7,d7<1+(2**-8))
    s.add(1-(2**-8)<d8,d8<1+(2**-8))
    s.add(1-(2**-8)<d9,d9<1+(2**-8))
    s.add(1-(2**-8)<d10,d10<1+(2**-8))
    s.add(1-(2**-8)<d11,d11<1+(2**-8))
    s.add(1-(2**-8)<d12,d12<1+(2**-8))
    s.add(1-(2**-8)<d13,d13<1+(2**-8))
    s.add(1-(2**-8)<d14,d14<1+(2**-8))
    s.add(1-(2**-8)<d15,d15<1+(2**-8))
    s.add(1-(2**-8)<d16,d16<1+(2**-8))
    s.add(1-(2**-8)<d17,d17<1+(2**-8))
    s.add(1-(2**-8)<d18,d18<1+(2**-8))
    s.add(1-(2**-8)<d19,d19<1+(2**-8))
    s.add(1-(2**-8)<d20,d20<1+(2**-8))
    s.add(1-(2**-8)<d21,d21<1+(2**-8))
    s.add(1-(2**-8)<d22,d22<1+(2**-8))
    s.add(1-(2**-8)<d23,d23<1+(2**-8))
    s.add(1-(2**-8)<d24,d24<1+(2**-8))
    s.add(1-(2**-8)<d25,d25<1+(2**-8))
    s.add(0<x26,x26<1)
    s.add(0<x27,x27<1)
    s.add(0<x28,x28<1)
    s.add(0<x29,x29<1)
    s.add(0<x30,x30<1)
    s.add(0<x31,x31<1)
    s.add(0<x32,x32<1)
    s.add(0<x33,x33<1)
    s.add(0<x34,x34<1)
    s.add(0<x35,x35<1)
    s.add(0<x36,x36<1)
    s.add(0<x37,x37<1)
    s.add(0<x38,x38<1)
    s.add(0<x39,x39<1)
    s.add(0<x40,x40<1)
    s.add(0<x41,x41<1)
    s.add(0<x42,x42<1)
    s.add(0<x43,x43<1)
    s.add(0<x44,x44<1)
    s.add(0<x45,x45<1)
    s.add(0<x46,x46<1)
    s.add(0<x47,x47<1)
    s.add(0<x48,x48<1)
    s.add(0<x49,x49<1)
    s.add(0<x50,x50<1)

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
print('The new upper limit is ',U,' old upper limit is ',upper_limit)
print ('[ ',L,' ',U, ']')
print('Elapsed Time = %.5f second' %(time.process_time() - t))
