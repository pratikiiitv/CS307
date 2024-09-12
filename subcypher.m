function [codedtext] = subcypher(letters,randommap,plaintext)

% Function takes input as (letters, randommap, plaintext)
% Produces the substitution cypher text - codedtext in output
% letters = ABCDEFGHIJKLMNOPQRSTUVWXYZ
% code-randommap    = MNOPQRSTUVWXYZABCDEFGHIJKL
% Replace M with A, N with B etc.. in plaintext
% Avoids symbols which are not alphabets, for example space, ?, . etc.

L = length(plaintext);
codeletters = letters(randommap);

for i=1:L
	if (length(strfind(letters,upper(plaintext(i))))==0 || plaintext(i)==" ")
 		codedtext(i) = plaintext(i);	
	else
		codedtext(i) = letters(strfind(codeletters,upper(plaintext(i))));
	end
end

end