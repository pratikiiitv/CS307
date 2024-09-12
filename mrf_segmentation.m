%
%
% Author : Pratik Shah
% Date : February 25, 2020
% Demo exercise: CS308 Introduction to AI
%
% Markov Random Field for Segmentation
%
%

clear all;
close all;

%I = imread("noisy_checkerboard_mrf.jpg");
%[M,N] = size(I);

M = 100; N=100;
I(1:100,1:50) = 150+30*randn(100,50);
I(1:100,51:100) = 50 + 30*randn(100,50);

S11 = 1:10; S12 = 1:10;
S21 = 90:100; S22 = 90:100;

C1 = I(S11,S12); % class label 1
C2 = I(S21,S22); % class label 2

m(1) = mean(C1(:));
m(2) = mean(C2(:));
s(1) = std(C1(:));
s(2) = std(C2(:));

beta = -100;

% initialize a random assignment of labels {1,2}

%x = 1 + round(rand(M,N));
x1 = abs(I-m(1)); x2 = abs(I-m(2));
x12 = x1-x2;
x12(x12>=0) = 2;
x12(x12<0) = 1;

x = x12;
x(S11,S12) = 1; x(S21,S22)=2; % Known labels
Usingle = sum(sum(log(sqrt(2*pi*s(x).^2))+(I-m(x))./(2*s(x).^2))) ; 
Udouble = beta*(sum(sum(1-abs(diff(x,1,1))))+sum(sum(1-abs(diff(x,1,2)))));
Uold = Usingle+Udouble;

iter_max = 75000;
T = 10000;
for i = 1:iter_max
 xnew = x;
 xnew(randperm(M,1),randperm(N,1)) = 1+mod(xnew(randperm(M,1),randperm(N,1)),2);
 Usingle = sum(sum(log(sqrt(2*pi*s(xnew).^2))+(I-m(xnew))./(2*s(xnew).^2))) ; 
 Udouble = beta*(sum(sum(1-abs(diff(xnew,1,1))))+sum(sum(1-abs(diff(xnew,1,2)))));
 Unew = Usingle+Udouble;
 deltaU = Unew-Uold;
 if deltaU <= 0
  x = xnew; Uold=Unew;
 else
  if rand < exp(-deltaU/T)
   x = xnew; Uold=Unew;
  end
 end
 T = (T+i)/i;
 x(S11,S12) = 1; x(S21,S22)=2;
end

figure(1); hold on;
subplot(2,2,1); imshow(uint8(I)); hold on;
subplot(2,2,3); imshow(2-x12); hold on;
subplot(2,2,4); imshow(2-x);
