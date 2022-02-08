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
function [covertext, originaltext] = DecodeSteganoPart5(steganotext,mappingtable)
clc
bits = 6;
kashidadec = 1600;


ListBreaks=[46, 58, 32, 44 , 1548, 45, 95, 40, 41, 91, 93, 123, 125, 34, 47];
[~,Kashidaletters]  = xlsread('letters.xlsx','B1:B23');
[Harakatsymbol,~]  = xlsread('letters.xlsx','D1:D8');
[~,np]  = xlsread('letters.xlsx','F1:F13');
[~,tp]  = xlsread('letters.xlsx','H1:H12');
[~,bp]  = xlsread('letters.xlsx','G1:G3');


steganotext = uint16(steganotext);
covertext=steganotext;
covertext(find(covertext==kashidadec))=[];

originaltext=[];
originaltextbits=[];


stopcount=0;
j=1;

while j <= length(steganotext)-1
    
    letter = char(steganotext(j));
    %         letter
    %     if steganotext(j) == 1604 % letter == Lam
    %         if steganotext(j+1) == 1575 || steganotext(j+1) == 1571 % letter == alif
    %             j=j+1;
    %             continue;
    %         end
    %     end
    
    
    [index, value] =Searchforletter(Kashidaletters,   letter);
    if value == 1
        [findit, stp] = lookforbreaks(steganotext, j, ListBreaks,Harakatsymbol);
        if findit == false
            if  steganotext(j+stp+1)==kashidadec
                
                if (ismember(char(steganotext(j)), tp) || ismember(char(steganotext(j)), bp)) &&  (ismember(char(steganotext(j+2)), tp) || ismember(char(steganotext(j+2)), bp))
                    stopcount=0;
                    steganotext(j+stp+1)=[];
                    originaltextbits=[originaltextbits 0 0];
                    
                elseif (ismember(char(steganotext(j)), tp) || ismember(char(steganotext(j)), bp)) &&  (ismember(char(steganotext(j+2)), np))
                    stopcount=0;
                    steganotext(j+stp+1)=[];
                    originaltextbits=[originaltextbits 0 1];
                    
                elseif ismember(char(steganotext(j)), np) &&  ismember(char(steganotext(j+2)), np)
                    stopcount=0;
                    steganotext(j+stp+1)=[];
                    originaltextbits=[originaltextbits 1 0];
                    
                elseif ismember(char(steganotext(j)), np) &&  (ismember(char(steganotext(j+2)), tp) || ismember(char(steganotext(j+2)), bp))
                    stopcount=stopcount+2;
                    
                    steganotext(j+stp+1)=[];
                    originaltextbits=[originaltextbits 1 1];
                end
                
                
                
            end
        end
    end
    j= j+1;
    if mod(length(originaltextbits),bits)==0 && stopcount~=bits
        stopcount=0;
    elseif mod(length(originaltextbits),bits)==0 && stopcount==bits
        break;
    end
end


z=1;
for i=1:bits:length(originaltextbits)
    try
        letterbits=originaltextbits(i:z*bits);
        if sum(letterbits)==bits
            break;
        end
        letterbits= mat2str(letterbits);
        letterbits=strrep(letterbits,'[','');
        letterbits=strrep(letterbits,']','');
        
        for j =1:length(mappingtable)
            if strcmp(mappingtable{j,2}, letterbits)
                originaltext=[originaltext uint16(mappingtable{j,1})];
                break;
            end
        end
        z=z+1;
    catch
    end
end
disp('Decode Part1')
covertext = char(covertext)
originaltext = char(originaltext)
end