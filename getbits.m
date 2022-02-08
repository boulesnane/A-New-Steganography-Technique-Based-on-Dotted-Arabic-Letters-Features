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

function [bitsseries] = getbits(originaltextbits, steganotext, j)

bitsseries = [];

ListBreaks=[46, 58, 32, 44 , 1548, 45, 95, 40, 41, 91, 93, 123, 125, 34, 47];

[~,np]  = xlsread('letters.xlsx','F1:F13');
[~,op]  = xlsread('letters.xlsx','I1:I10');
[~,twp]  = xlsread('letters.xlsx','J1:J3');
[~,thp]  = xlsread('letters.xlsx','K1:K2');

[~,tp]  = xlsread('letters.xlsx','H1:H12');
[~,bp]  = xlsread('letters.xlsx','G1:G3');

if j==1
    bitsseries = [0 0 0];
else
    if ismember(steganotext(j-1), ListBreaks)
        bitsseries = [0 0 0];
    elseif ismember(char(steganotext(j)), np) && ~ismember(steganotext(j-1), ListBreaks)
        bitsseries = [0 0 1];
    elseif ismember(char(steganotext(j)), tp) && ismember(char(steganotext(j)), op) && ~ismember(steganotext(j-1), ListBreaks)
        bitsseries = [0 1 0];
    elseif ismember(char(steganotext(j)), tp) && ismember(char(steganotext(j)), twp) && ~ismember(steganotext(j-1), ListBreaks)
        bitsseries = [0 1 1];
    elseif ismember(char(steganotext(j)), tp) && ismember(char(steganotext(j)), thp) && ~ismember(steganotext(j-1), ListBreaks)
        bitsseries = [1 0 0];
    elseif ismember(char(steganotext(j)), bp) && ismember(char(steganotext(j)), op) && ~ismember(steganotext(j-1), ListBreaks)
        bitsseries = [1 0 1];
    elseif ismember(char(steganotext(j)), bp) && ismember(char(steganotext(j)), twp) && ~ismember(steganotext(j-1), ListBreaks)
        bitsseries = [1 1 0];
    end
end


end