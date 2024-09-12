function [dis] = path_cost_tour(s,D)

% Distance calculation / Path Cost for a tour s
[N,M] = size(D);
dis = 0;
for i=1:N-1
 dis = dis + D(s(i),s(i+1));
end
dis = dis + D(s(N),s(1));

