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
function [steganotext1,mappingtable, Stegobitsused,Secretbits] = Dot_Kashida(covertext, secrettext)
clc
steganotext1= uint16(covertext);
finishingletter ='$';
bits = 6;
kashidadec = 1600;
Stegobitsused=0;
Secretbits=0;
histoBits =[];
% ListBreaks=['.', ':', ' ',',','?','-','_','(',')','[',']','{','}','"','/'];
ListBreaks=[46, 58, 32, 44 , 1548, 45, 95, 40, 41, 91, 93, 123, 125, 34, 47];


[~,Nonkashidaletters]  = xlsread('letters.xlsx','A1:A14');
[~,Kashidaletters]  = xlsread('letters.xlsx','B1:B23');
[Harakatsymbol,~]  = xlsread('letters.xlsx','D1:D8');




mappingtable= {};
for i=1:length(Nonkashidaletters)
    b = de2bi( i , bits );
    b= mat2str(b);
    b=strrep(b,'[','');
    b=strrep(b,']','');
    b = flip(b);
    
    mappingtable{i,1}= Nonkashidaletters{i};
    mappingtable{i,2}= b;
    mappingtable{i,3}= KashidaCost(b,bits);
    mappingtable{i,4}= 0;
end

for j= 1:length(Kashidaletters)
    i= i+1;
    b = de2bi( i , bits );
    b= mat2str(b);
    b=strrep(b,'[','');
    b=strrep(b,']','');
    b = flip(b);
    
    mappingtable{i,1}= Kashidaletters{j};
    mappingtable{i,2}= b;
    mappingtable{i,3}= KashidaCost(b,bits);
    mappingtable{i,4}= 0;
end

mappingtable = sortrows(mappingtable,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
secrtbits=[];
for i= 1:length(secrettext)
    letter = secrettext(i);
    [index, value] =Searchforletter(mappingtable, letter);
    
    if value == 1
        [mappingtable, newindex]=getMinKashidaCost(mappingtable, index);
        
        if isempty(secrtbits)
            secrtbits= mappingtable{newindex,2};
        else
            secrtbits = [secrtbits ' ' mappingtable{newindex,2}];
        end
    else
        index = length(mappingtable)+1;
        b = de2bi( index , bits );
        b= mat2str(b);
        b=strrep(b,'[','');
        b=strrep(b,']','');
        b = flip(b);
        
        mappingtable{index,1}= letter;
        mappingtable{index,2}= b;
        mappingtable{index,3}= KashidaCost(b,bits);
        mappingtable{index,4}= 1;
        mappingtable = sortrows(mappingtable,3);
        
        if isempty(secrtbits)
            secrtbits= mappingtable{index,2};
        else
            secrtbits = [secrtbits ' ' mappingtable{index,2}];
        end
    end
    
end

index = length(mappingtable)+1;
mappingtable{index,1}= finishingletter;
mappingtable{index,2}=strrep(mappingtable{1,2},'0','1');
mappingtable{index,3}= KashidaCost(mappingtable{index,2},bits);
mappingtable{index,4}= 1;
mappingtable = sortrows(mappingtable,3);

% secrtbits = [secrtbits ' ' mappingtable{index,2}];



Secretbits=length(strrep(secrtbits,' ',''));

segbits=[];
j=1;
z=1;
stop = false;
i=1;
while i<=length(secrtbits)
    %     secrtbits(i)
    if i == z*2*bits+1
        z= z+1;
    end
    
    segbits = secrtbits(i:z*2*bits-1);
    segbits= strrep( segbits, ' ', '');
    
    onesbits = mappingtable{length(mappingtable),2};
    onesbits= strrep( onesbits, ' ', '');
    
    if strcmp(segbits, onesbits) ||  j > length(steganotext1)-1
        stop = true;
        break;
    end
    
    while j <= length(steganotext1)-1
        
        letter = char(steganotext1(j));
        %         letter
        %         if steganotext1(j) == 1604 % letter == Lam
        %             if steganotext1(j+1) == 1575 || steganotext1(j+1) == 1571 % letter == alif
        %                 j=j+1;
        %                 continue;
        %             end
        %         end
        
        
        [index, value] =Searchforletter(Kashidaletters,   letter);
        if value == 1
            [findit, stp] = lookforbreaks(steganotext1, j, ListBreaks,Harakatsymbol);
            if findit == false
                [truepattren, NEWi] = pattrenbits(secrtbits, i,length(secrtbits), steganotext1, j);
                if truepattren
                    steganotext1 =[steganotext1(1:j+stp)  kashidadec  steganotext1(j+stp+1:length(steganotext1))];
                    Stegobitsused = Stegobitsused + 3;
                    histoBits =[histoBits 3];
                    j= j+1;
                    i=NEWi+1;
                    break;
                else
                    if  str2num(secrtbits(i))==1
                        steganotext1 =[steganotext1(1:j+stp)  kashidadec kashidadec steganotext1(j+stp+1:length(steganotext1))];
                        Stegobitsused = Stegobitsused + 1;
                        histoBits =[histoBits 1];
                        j= j+1;
                        i=i+2;
                        break;
                    elseif str2num(secrtbits(i))==0
                        Stegobitsused = Stegobitsused + 1;
                        histoBits =[histoBits 1];
                        j= j+1;
                        i=i+2;
                        break;
                    else
                        histoBits =[histoBits 0];
                    end
                end
            end
        end
        j= j+1;

    end
    
end


disp('random level')
onesletters =bits;
if stop % if there is no more secret letters, we add kashida randomly
    while j <= length(steganotext1)-1
        letter = char(steganotext1(j));
        %         letter
        %         j
        
        %         if steganotext1(j) == 1604 % letter == Lam
        %             if steganotext1(j+1) == 1575 || steganotext1(j+1) == 1571 % letter == alif
        %                 j=j+1;
        %                 continue;
        %             end
        %         end
        
        [index, value] =Searchforletter(Kashidaletters,   letter);
        if value == 1
            [findit, stp] = lookforbreaks(steganotext1, j, ListBreaks,Harakatsymbol);
            if findit == false
                if onesletters <=bits && onesletters > 0
                    steganotext1 =[steganotext1(1:j+stp)  kashidadec kashidadec steganotext1(j+stp+1:length(steganotext1))];
                    onesletters=onesletters-1;
                    j= j+1;
                else
                    if  rand <= 0.5
                        steganotext1 =[steganotext1(1:j+stp)  kashidadec kashidadec steganotext1(j+stp+1:length(steganotext1))];
                        j= j+1;
                        
                    else
                        steganotext1 =[steganotext1(1:j+stp)  kashidadec steganotext1(j+stp+1:length(steganotext1))];
                        j= j+1;
                    end
                end
            end
        end
        j= j+1;
        (double(j)/double(length(steganotext1)))*100
    end
end


disp('Part1')
secrettext
secrtbits
steganotext1 = char(steganotext1);
end