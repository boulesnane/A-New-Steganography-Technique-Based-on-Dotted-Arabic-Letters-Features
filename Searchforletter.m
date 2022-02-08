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

function [index, value]=Searchforletter(mappingtable, letter)
value = false;
index = -1;

for i= 1 :  size(mappingtable,1)
    if mappingtable{i,1}==letter
        value= true;
        index = i;
        break;
    end
end
end