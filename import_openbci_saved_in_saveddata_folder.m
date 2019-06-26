
definput = {'Fp1,Fp2,C3,C4,T5,T6,O1,O2,F7,F8,F3,F4,T3,T4,P3,P4,MRK1,MRK2,AUX'};

try
    eeg_emptyset();
catch
    eeglab;
    close all;
end
[file,path] = uigetfile('*.txt');
file=fullfile(path,file);
T = readtable(file);
data = T{1:end,2:20};
data=data';

EEG = pop_importdata('dataformat','array','nbchan',0,'data','data','srate',125,'pnts',0,'xmin',0);


disp('Completed, please enter channel labels');
prompt = {'Enter the channel labels'};
dlgtitle = 'Channel labels';
%opts.Interpreter = 'tex';
answer = inputdlg(prompt,dlgtitle,[1 80],definput);

if length(answer)>0
    labels=strsplit(answer{1},',');
    
    if length(labels)==19
        for i=1:EEG.nbchan
            EEG.chanlocs(i).labels=labels{i};
        end
        EEG=pop_chanedit(EEG, 'lookup','standard-10-5-cap385.elp');

    end
end

eeglab redraw;


