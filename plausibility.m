function [logerror] = plausibility(letters,m,detext)

L = length(detext);
logerror = 0;
for i=1:L-1
	if (length(strfind(letters,upper(detext(i+1))))==0)
 		detext(i+1) = " ";
	end
	logerror = logerror + log(m(letters==upper(detext(i)),letters==upper(detext(i+1))));
end

end
