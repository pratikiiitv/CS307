% ---------------------------------------------------------
% Author : Pratik Shah
% Date: May 6, 2020  
%
% Simulated Annealing Example
% Binary KnapSack Problem
%
% N - number of objects
% v - values of objects
% w - weights of objects
% x - binary state vector 
% ---------------------------------------------------------


clear all;
close all;

N = 100; % Number of objects
K = 100;
v = rand(1,N); % Values of objects
w = round(100*rand(1,N)); % Weights of objects
mu = 100; % Penalty weightage for violating capacity
P = 1000; % Capacity of knapsack
x = rand(1,N); x(x>=.5)=1;x(x<.5)=0;
xint = x;
W = x*w';
V = x*v';

Tmax = 1000;
iter_max = 100000;
E1 = costKnapsack(x,v,w,P,mu);
E = E1;
for i=1:10000%iter_max
 id = randperm(N,1);
 xnew = x;
 xnew(id) = mod(x(id)+1,2);
 E2 = costKnapsack(xnew,v,w,P,mu);
 T = Tmax/i;
 if E1<E2
  x = xnew;
  E1 = E2;
 else
  if (rand<exp(-(E1-E2)/T)) 
   x = xnew;
   E1 = E2;
  end
 end
 W = [W x*w']; V = [V x*v']; E=[E E1];
end

figure(1);
subplot(1,3,1);plot(W); 
subplot(1,3,2);plot(V,'r'); 
subplot(1,3,3);plot(E,'k');
