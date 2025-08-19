function [f] = costKnapsack(x,v,w,P,mu)
 f1 = x*v';
 f2 = min(0,(P-x*w')/P);
 f = f1+mu*f2;
end
