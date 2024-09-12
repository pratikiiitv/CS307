iter_max = 5000;
for i = 1:iter_max
	proposalswap = randperm(26,2);
	currmapp = prevmapp;
	currmapp(proposalswap(1)) = prevmapp(proposalswap(2));
	currmapp(proposalswap(2)) = prevmapp(proposalswap(1));
	currdecodedtext = subcypher(letters,currmapp,codedtext);
	currplaus = plausibility(letters,m,currdecodedtext);
	if(currplaus > prevplaus)
		prevmapp = currmapp;
		prevplaus = currplaus;
		prevdecodedtext = currdecodedtext;
		if(prevplaus>maxplaus)
			maxplaus = prevplaus;
			maxmapp = prevmapp;	
			maxdecodedtext = prevdecodedtext;
		end
    	end

end
disp(maxdecodedtext);

