
import sys, string
Rval = 0.0;
Oval = 0.0;
Pval = 0.0;
res = 0.0;

try:
    Oval = float(sys.argv[1])
except IndexError:
     print "oops"
Rval = Oval * 3.14;
Pval = Rval * 2.5;
res = Rval + Oval + Pval;
res = res / 6.0;

print '%10f'% (res)
