%---------------------------------------------------
% Markov Chain Monte Carlo
% Author : Pratik Shah
% Date : May 12, 2020
% Place : Gandhinagar
% Ref : Breaking substitution cypher using MCMC, , Perci Diaconis
%--------------------------------------------------

clear all;
close all;
load warandpeace.mat
load letters.mat
% Random mapping for coding the string
%plaintext = "In moral and political philosophy, the social contract or political contract is a theory or model, originating during the Age of Enlightenment, that typically addresses the questions of the origin of society and the legitimacy of the authority of the state over the individual. Social contract arguments typically posit that individuals have consented, either explicitly or tacitly, to surrender some of their freedoms and submit to the authority of the ruler or magistrate (or to the decision of a majority), in exchange for protection of their remaining rights.";
plaintext ='Once on a dark winter,s day, when the yellow fog hung so thick and heavy in the streets of London that the lamps were lighted and the shop windows blazed with gas as they do at night, an odd-looking little girl sat in a cab with her father and was driven rather slowly through the big thoroughfares. She sat with her feet tucked under her, and leaned against her father, who held her in his arm, as she stared out of the window at the passing people with a queer old-fashioned thoughtfulness in her big eyes. She was such a little girl that one did not expect to see such a look on her small face.  It would have been an old look for a child of twelve, and Sara Crewe was only seven.  The fact was, however, that she was always dreaming and thinking odd things and could not herself remember any time when she had not been thinking things about grown-up people and the world they belonged to. She felt as if she had lived a long, long time. At this moment she was remembering the voyage she had just made from Bombay with her father, Captain Crewe.  She was thinking of the big ship, of the Lascars passing silently to and fro on it, of the children playing about on the hot deck, and of some young officers. wives who used to try to make her talk to them and laugh at the things she said.';
randommap = randperm(26);
randommap(27) = 27;
% Generate Cypher text using randommap
codedtext = subcypher(letters,randommap,plaintext);

%---------------------------------------------------
% MCMC Algorithm
%---------------------------------------------------
prevmapp = randperm(26); 
prevdecodedtext = subcypher(letters,prevmapp,codedtext);
prevplaus = plausibility(letters,m,prevdecodedtext);	

maxdecodedtext = prevdecodedtext;
maxplaus = prevplaus;
maxmapp = prevmapp;

iter_max = 100;
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
			
	


