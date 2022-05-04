load hw1xtr.dat;
load hw1ytr.dat;
x = hw1xtr(:,1);
y = hw1ytr(:,1);
k = 5;
gx = reshape(x,k,[])
gy = reshape(y,k,[]);
ihat = eye();
j = [];
xv = gx(5,:);
yv = gy(5,:);
wg = []

for i=1:(k-1)
    xt = gx(i,:);
    xt = xt';
    y = gy(i,:);
    y = y';
    xn = [xt.^4 xt.^3 xt.^2 xt xt.^0];
    w  = inv(xn'*xn) * xn'*y;
    wg = [wg w]
    syms t
    f = @(t) w(1)*t.^4+w(2)*t.^3+w(3)*t.^2+w(4)*t+w(5);
    err = 0;
    for i = 1:8
        err = err+(f(xv(i))-yv(i))^2;
    end
    err = err/8;
    j = [j err];
end

size(j)