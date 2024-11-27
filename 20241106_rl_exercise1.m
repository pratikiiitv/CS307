clear all;
close all;

% Environment p(s',r|s,a)
% Rewards are tied with states s'
% So primarily we need probability of moving to state s' from s by taking action a
% We denote the set of states by {1, 2, 3, 4}
% Set of actions by {1,2,3,4} - {up, down, left, right}
% p(s',s,a) denotes p(s'|s,a)

p(1,1,1)=.9; p(1,1,2)=.1; p(1,1,3)=.9; p(1,1,4)=.1;
p(2,1,1)=0 ; p(2,1,2)=.8; p(2,1,3)=.1; p(2,1,4)=.1;
p(3,1,1)=.1; p(3,1,2)=.1; p(3,1,3)= 0; p(3,1,4)=.8;
p(4,1,1)= 0; p(4,1,2)= 0; p(4,1,3)= 0; p(4,1,4)= 0;

% Permutation can be used for symmetry
% Rotation by 90 clockwise
% s2->s1; s1->s3; s3->s4; s4->s2; Perm[2 1 3 4]
% up->right; down->left; left->up; right->down
% 1->4; 2->3; 3-1; 4->2; Perm[1 4 2 3]
% p(s'|s,a)
p(1,3,1)=.1; p(1,3,4)= 0;
p(2,3,4)= 0;
p(3,3,4)=.9;  
p(4,3,4)=.1;

% Rotation by 180
States:
Actions:

% Rotation by 270
States:
Actions: