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

function [mappingtable, newindex]=getMinKashidaCost(mappingtable, index)
newindex = -1;

if  mappingtable{index,4} == 1
    newindex = index;
else
    for i= 1:length(mappingtable)
        if  mappingtable{i,4} == 0
            newindex = i;
            
            tmp  = mappingtable{index,1};
            mappingtable{index,1}= mappingtable{i,1};
            mappingtable{i,1}= tmp;
            
            mappingtable{index,4} = 0;
            mappingtable{i,4} = 1;
            break;
        end
        
    end
end
end