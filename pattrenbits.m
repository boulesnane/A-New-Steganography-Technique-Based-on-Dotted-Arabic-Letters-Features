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
function [truepattren, NEWi] = pattrenbits(secrtbits, i,lenSB, steganotext1, j)

NEWi = i;
truepattren = false;
if i<= (lenSB - 5)
ListBreaks=[46, 58, 32, 44 , 1548, 45, 95, 40, 41, 91, 93, 123, 125, 34, 47];

[~,np]  = xlsread('letters.xlsx','F1:F13');
[~,op]  = xlsread('letters.xlsx','I1:I10');
[~,twp]  = xlsread('letters.xlsx','J1:J3');
[~,thp]  = xlsread('letters.xlsx','K1:K2');

[~,tp]  = xlsread('letters.xlsx','H1:H12');
[~,bp]  = xlsread('letters.xlsx','G1:G3');

if j==1 && strcmp(strrep(secrtbits(i:i+5),' ',''),'000')
    truepattren =true;
    NEWi = NEWi +5;
else
    if ismember(steganotext1(j-1), ListBreaks) && strcmp(strrep(secrtbits(i:i+5),' ',''),'000')
        truepattren =true;
        NEWi = NEWi +5;
    elseif ismember(char(steganotext1(j)), np) && ~ismember(steganotext1(j-1), ListBreaks) && strcmp(strrep(secrtbits(i:i+5),' ',''),'001')
        truepattren =true;
        NEWi = NEWi +5;
    elseif ismember(char(steganotext1(j)), tp) && ismember(char(steganotext1(j)), op) && ~ismember(steganotext1(j-1), ListBreaks) && strcmp(strrep(secrtbits(i:i+5),' ',''),'010')
        truepattren =true;
        NEWi = NEWi +5;
    elseif ismember(char(steganotext1(j)), tp) && ismember(char(steganotext1(j)), twp) && ~ismember(steganotext1(j-1), ListBreaks) && strcmp(strrep(secrtbits(i:i+5),' ',''),'011')
        truepattren =true;
        NEWi = NEWi +5;
    elseif ismember(char(steganotext1(j)), tp) && ismember(char(steganotext1(j)), thp) && ~ismember(steganotext1(j-1), ListBreaks) && strcmp(strrep(secrtbits(i:i+5),' ',''),'100')
        truepattren =true;
        NEWi = NEWi +5;
    elseif ismember(char(steganotext1(j)), bp) && ismember(char(steganotext1(j)), op) && ~ismember(steganotext1(j-1), ListBreaks) && strcmp(strrep(secrtbits(i:i+5),' ',''),'101')
        truepattren =true;
        NEWi = NEWi +5;
    elseif ismember(char(steganotext1(j)), bp) && ismember(char(steganotext1(j)), twp) && ~ismember(steganotext1(j-1), ListBreaks) && strcmp(strrep(secrtbits(i:i+5),' ',''),'110')
        truepattren =true;
        NEWi = NEWi +5;
    end
end

end
end