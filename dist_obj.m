%---------------------------------------------
%	Author:	Pratik Shah
%	Place:	Gandhinagar
%	Date:	20 Jan, 2021
%
%	Experiment on Simulated Annealing
%	Markov Chain with transition probability	
%	as a function of temperature and 
%	stationary distribution of objective values 
%	
%--------------------------------------------

clear all;
close all;

t = 0:.01:4*pi;

% Objective function
function [f] = energy(t)
f = exp(-t/pi) .*( 5*sin(t)+4*sin(4*t)+3*sin(3*t)+2*sin(2*t));
end


% Plot distribution of objective values
F = energy(t);
[h, l] = hist(F, 50);
h = h/length(t);

N = length(t);
K = 1000; c=100;
s_init = 1;

function [p] = prob_calc(F1, F2, c)
	if F2 < F1
		p = 1;
	else
		p = exp((F1-F2)/c);
	end
end


p =[]; s = s_init;
for iter = 1:K
% Choose a state from 1:N randomly
	s_next = randperm(N,1);
	p(s_init,s_next)= prob_calc(F(s_init),F(s_next), c);
	if rand < p(s_init, s_next)
		s_init = s_next;
		s = [s s_init];
	end	
end


figure(1); subplot(2,1,1); hist(F,50); 
subplot(2,1,2); hist(F(s),50);

