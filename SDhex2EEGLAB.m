clear
eeglab
clc
%close all
[file,path] = uigetfile('*.txt');
fileID=fopen(fullfile(path,file));
disp('Please be patient. This will take some time...');
wait=['.'];
i=1;
numOfDiscontinuity=0;
while 1
    tline = fgetl(fileID);
    if ~ischar(tline), break, end
    splitLine=strsplit(tline,',');
    if length(splitLine)==1 && splitLine{1}(1)=='%' %when there are %start and stop signs
        numOfDiscontinuity=numOfDiscontinuity + 1;
        discontinuity(numOfDiscontinuity)=i;
    end
    if length(splitLine)>3
        arrayMicrovolts=hexToMicroVolts(splitLine);
        if length(arrayMicrovolts)==19
            matrixMicroVolts(i,:)=arrayMicrovolts;
        elseif length(arrayMicrovolts)==16
            matrixMicroVolts(i,:)=[arrayMicrovolts 0 0 0];
        else
            matrixMicroVolts(i,:)=zeros(1,19);
        end
    end
    i=i+1;
    
    if mod(i,3000)==0
        
        disp(wait);
        wait=[wait '.'];
    end
    
    
end

EEG.data=matrixMicroVolts';
EEG.srate=250;
EEG.nbchan=19;


disp('Completed, please enter channel labels');
prompt = {'Enter the channel labels'};
dlgtitle = 'Channel labels';
definput = {'Fp1,Fp2,C3,C4,T5,T6,O1,O2,F7,F8,F3,F4,T3,T4,P3,P4,MRK1,MRK2,AUX'};
%opts.Interpreter = 'tex';
answer = inputdlg(prompt,dlgtitle,[1 80],definput);

if length(answer)>0
labels=strsplit(answer{1},',');

for i=1:EEG.nbchan
EEG.chanlocs(i).labels=labels{i};
end
end


disp('Loading locations');
EEG=pop_chanedit(EEG, 'lookup','standard-10-5-cap385.elp');

disp(['Saving file to: ' fullfile(path,[file(1:end-3) 'gdf'])]);
pop_writeeeg(EEG, fullfile(path,[file(1:end-3) 'gdf']), 'TYPE','GDF');


offset=length(EEG.event)+1
for i=1:numOfDiscontinuity
    EEG.event(i+offset).type='DIS';
    EEG.event(i+offset).latency=discontinuity(i);
    EEG.event(i+offset).duration=1;
    EEG.event(i+offset).urevent=0;
end

disp('Opening EEGLAB...');
eeglab redraw;


