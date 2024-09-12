% ---------------------------------------------------------
% Author : Pratik Shah
% Date: January 25, 2020  
%
% CS308 AI - Simulated Annealing Example
% Travelling Salesman Problem
%
% N - number of nodes
% D - random distance matrix
% s - tour
% p - transition probability with iteration
% d - tour cost with iteration
% ---------------------------------------------------------

clear all;
close all;
rng(100);

%---------Random distance matrix------------
% N = 5;
% D = 1+floor(10*rand(N,N));
% D = D - diag(diag(D)); % Distance matrix 
%-------------------------------------------

%--- random nodes in R2 -------------------
N = 1000;
D = zeros(N,N);
x = rand(2,N);
for i=1:N-1
    for j=i+1:N
        D(i,j)=norm(x(:,i)-x(:,j));
        D(j,i)=D(i,j);
    end
end
%-----------------------------------------

s = randperm(N); % Initial solution
sinit = s;
ds = path_cost_tour(s,D); 
d = ds; p = [];
Tm = 1000; 
iter_max = 500000;
for i=1:iter_max
 id = randperm(N,2);
 id = sort(id);
 snext = s;
%----First Neighbor Operator -------
% snext(id(1)) = s(id(2));
% snext(id(2)) = s(id(1));
%----Second Neighbor Operator-------
 snext(id(1):id(2))=s(id(2):-1:id(1));
 
 dsnext = path_cost_tour(snext,D);
 E = ds-dsnext; % to check for minimum direction
 T = Tm/i;
 pE = 1/(1+exp(-E/T)); 
 if E>0 
  s = snext;
 else
  if rand < pE 
   s = snext;
  end
 end
 ds = path_cost_tour(s,D);
 d = [d, ds];
 p = [p, pE];
end
%------------------
figure(1);
subplot(1,2,1);
axis([0 1 0 1]);plot(x(1,[sinit sinit(1)]),x(2,[sinit sinit(1)]),'-+')
subplot(1,2,2);
axis([0 1 0 1]);plot(x(1,[s s(1)]),x(2,[s s(1)]),'-+');

