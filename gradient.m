syms x y z
f(x, y, z) = 2*y*z*sin(x);
gradient(f,[x,y,z])

fplot(f)