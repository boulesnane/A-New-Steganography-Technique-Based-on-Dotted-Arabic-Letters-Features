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

function [newcovertext,newsecrettext] = PrepareCoverText(covertext,secrettext)


newsecrettext=[];
[r,c]=size(secrettext);
if r > 1
for i = 1 : r 

        newsecrettext=[newsecrettext ' '  secrettext{i,1}];
  
end
else
newsecrettext=secrettext;
end

newsecrettext=char(newsecrettext);


newcovertext=[];
[r,c]=size(covertext);
if r > 1
for i = 1 : r 

        newcovertext=[newcovertext ' '  covertext{i,1}];
  
end
else
newcovertext=covertext;
end

newcovertext=char(newcovertext);
[Harakatsymbol,~]  = xlsread('letters.xlsx','D1:D8');
newcovertext= uint16(newcovertext);

i=1;
while i<=length(newcovertext)
   if ismember(newcovertext(i), Harakatsymbol)
       newcovertext(i)=[];
       i=1;
   else
       i=i+1; 
   end
     
end

% newcovertext= uint16(covertext);
newcovertext(find(newcovertext==1600))=[]; %look for kashida letter and clear it
newcovertext = char(newcovertext);
end