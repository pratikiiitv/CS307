clear all;
close all;


% Policy Stay
N = 10; % Number of simulations
R = [];
for n = 1:N
R_total(1) = 0;
flag = 1;
while flag != 0
if rand > 1/3
    R_total(i) = R_total(i-1)+4;
else
    R_total(i) = R_total(i-1)+4;
    flag = 0;
endif
endwhile
R = [R R_total];
endfor

