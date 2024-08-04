function [x,w]=gausshermite(n)
%produces x and w for a std normal distribution
%Aproximates integral using Gauss-Hermite method
p=hermipol(n);
%Roots
x=roots(p(n+1,:));
%Coeficients
for i=1:n
    w(i)=(2.^(n-1)*(factorial(n)))./(n.^2.*(polyval(p(n,1:n),x(i))).^2);    
end
x=sqrt(2)*x;
w=w.';
end

function p=hermipol(n)
    p(1,1)=1;
    p(2,1:2)=[2 0];
    for k=2:n
       p(k+1,1:k+1)=2*[p(k,1:k) 0]-2*(k-1)*[0 0 p(k-1,1:k-1)];
    end
end