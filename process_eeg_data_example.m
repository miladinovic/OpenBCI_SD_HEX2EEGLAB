%remove first 255 seconds (electrode setup...)
EEG = pop_select( EEG,'notime',[0 255] );

% Extract stimulus from channel 15 (values X>8)
EEG = pop_chanevent(EEG, 15,'typename','STM1','oper','X>8','edge','leading','edgelen',0,'delchan','off','delevent','off','nbtype',1);

% Extract stimulus from channel 14 (values X>10)
EEG = pop_chanevent(EEG, 14,'typename','STM2','oper','X>10','edge','leading','edgelen',0,'delchan','off','delevent','off','nbtype',1);

% Extract stimulus from channel 14 (values X>400) BTM1
EEG = pop_chanevent(EEG, 13,'typename','BTN1','oper','X>400','edge','leading','edgelen',0.5,'delchan','off','delevent','off','nbtype',1);

% Extract stimulus from channel 14 (values X>150 and X<300)
EEG = pop_chanevent(EEG, 13,'typename','BTN2','oper','and(X>150,X<300)','edge','leading','edgelen',0,'delchan','off','delevent','off','nbtype',1);

% Remove unused channels (13-16)
EEG = pop_select( EEG,'nochannel',[13:16] );

% Filter data from 0.5-45Hz
EEG = pop_eegfiltnew(EEG, 0.5,45);

%plot EEG
pop_eegplot( EEG, 1, 1, 1);