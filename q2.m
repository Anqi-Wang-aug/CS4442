load hw1xtr.dat;
load hw1ytr.dat;
% program for question 2
load hw1xte.dat;
load hw1yte.dat;
x = hw1xtr(:,1);
y = hw1ytr(:,1);
xt = hw1xte(:,1);
yt = hw1yte(:,1);
m = numel(x);
mt = numel(xt);

subplot(4,2,1)
plot(x,y,'.');
hold on
z = ones(size(y));
x1 = [x'; z'];
x1=x1';
w=inv(x1'*x1)*x1'*y;

syms t
f1= @(t) w(1)*t+w(2);

fplot(f1, [0,5]);

err1 = 0;
errsum1 = 0;
for i=1:m
    errsum1 = errsum1+(f1(x(i))-y(i))^2;
end
err1 = errsum1/m;

subplot(4,2,2)
plot(xt,yt,'.')
hold on
fplot(f1,[0,4])
err1 = 0;
errsum1 = 0;
for i=1:mt
    errsum1 = errsum1+(f1(xt(i))-yt(i))^2;
end
err1 = errsum1/mt;

subplot(4,2,3)
z = x.^2;
x2 = [z x1];
w = inv(x2'*x2)*x2'*y;
plot(x,y,'.')
hold on
syms t
f2 = @(t) w(1)*t.^2+w(2)*t+w(3);
fplot(f2,[0,5]);
err1 = 0;
errsum1 = 0;
for i=1:m
    errsum1 = errsum1+(f2(x(i))-y(i))^2;
end
err1 = errsum1/m;

subplot(4,2,4)
plot(xt,yt,'.')
hold on
fplot(f2,[0,5])
err1 = 0;
errsum1 = 0;
for i=1:mt
    errsum1 = errsum1+(f2(xt(i))-yt(i))^2;
end
err1 = errsum1/mt;

subplot(4,2,5)
plot(x,y,'.')
hold on
z = x.^3;
x3 = [z x2];
w = inv(x3'*x3)*x3'*y;
syms t
f3 = @(t) w(1)*t.^3+w(2)*t.^2+w(3)*t+w(4);
fplot(f3, [0,5]);
err1 = 0;
errsum1 = 0;
for i=1:m
    errsum1 = errsum1+(f3(x(i))-y(i))^2;
end
err1 = errsum1/m;

subplot(4,2,6)
plot(xt,yt,'.')
hold on
fplot(f3, [0,5]);
err1 = 0;
errsum1 = 0;
for i=1:mt
    errsum1 = errsum1+(f3(xt(i))-yt(i))^2;
end
err1 = errsum1/mt;

subplot(4,2,7)
plot(x,y,'.')
hold on
z = x.^4;
x4 = [z x3];
w = inv(x4'*x4)*x4'*y;
syms t
f4 = @(t) w(1)*t.^4+w(2)*t.^3+w(3)*t.^2+w(4)*t+w(5);
fplot(f4, [0,5]);
err1 = 0;
errsum1 = 0;
for i=1:m
    errsum1 = errsum1+(f4(x(i))-y(i))^2;
end
err1 = errsum1/m;

subplot(4,2,8)
plot(xt,yt,'.')
hold on
fplot(f3, [0,5]);
err1 = 0;
errsum1 = 0;
for i=1:mt
    errsum1 = errsum1+(f4(xt(i))-yt(i))^2;
end
err1 = errsum1/mt;

