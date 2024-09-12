%---------------------------------------------
% Learning state transition probabilities
% from War and Peace, Leo Tolstoy
% Save the matrix in warandpeace.mat
% How to use in future : load warandpeace.mat
% Date : May 12, 2020
% Author : Pratik Shah
% --------------------------------------------


clear all;
close all;

fileID = fopen("wnp.txt",'r');
wnptext = fscanf(fileID,'%c');
fclose(fileID);

letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ';
L = strlength(letters);
mxy = ones(L,L);
N = length(wnptext);

for i = 1:N-1
	if (length(strfind(letters,upper(wnptext(i+1))))==0)
 		wnptext(i+1) = " ";
	end
    mxy(letters==upper(wnptext(i)),letters==upper(wnptext(i+1)))=mxy(letters==upper(wnptext(i)),letters==upper(wnptext(i+1)))+1;
end
m = mxy./sum(mxy,2);

save warandpeace.mat m;
save letters.mat letters;




