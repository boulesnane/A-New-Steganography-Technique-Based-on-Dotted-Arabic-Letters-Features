%-------------------------------------------------------------------------
% Matlab Code for Arabic Text Steganography.
% by Using both Kashida and DIACRITICS methods.
% Programmed by Dr. Abdennour Boulesnane, Email: aboulesnane@univ-constantine3.dz

%-------------------------------------------------------------------------
% Please refer to the following journal article in your research papers:
% A. Boulesnane, A. Beggag and M. Zedadik, "A New Steganography Technique Based on Dotted Arabic Letters 
% Features," 2021 International Conference on Networking and Advanced Systems 
% (ICNAS), 2021, pp. 1-5, doi: 10.1109/ICNAS53565.2021.9628914.2007
%-------------------------------------------------------------------------

function [findit, stp] = lookforbreaks(steganotext1, j, ListBreaks,Harakatsymbol)
findit =false;
stp = 0;
while  ismember(steganotext1(j+1), Harakatsymbol)
    
    j=j+1;
    stp = stp+1;
    if j == length(steganotext1)
        findit =true;
        return;
    end
end

if ismember(steganotext1(j+1), ListBreaks)
    findit =true;
end
end