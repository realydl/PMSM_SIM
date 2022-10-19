FIS_CELEC = sugfis;


FIS_CELEC = addInput(FIS_CELEC,[-1 1],'Name','E');
FIS_CELEC = addMF(FIS_CELEC,'E','gaussmf',[0.7 -1],'Name','Negative');
FIS_CELEC = addMF(FIS_CELEC,'E','gaussmf',[0.7 1],'Name','Positive');

FIS_CELEC = addInput(FIS_CELEC,[-1 1],'Name','CE');
FIS_CELEC = addMF(FIS_CELEC,'CE','gaussmf',[0.7 -1],'Name','Negative');
FIS_CELEC = addMF(FIS_CELEC,'CE','gaussmf',[0.7 1],'Name','Positive');

FIS_CELEC = addOutput(FIS_CELEC,[200 400],'Name','u');
FIS_CELEC = addMF(FIS_CELEC,'u','constant',400,'Name','Big');
FIS_CELEC = addMF(FIS_CELEC,'u','constant',300,'Name','Mdl');
FIS_CELEC = addMF(FIS_CELEC,'u','constant',200,'Name','Sml');


ruleList = [1 1 1 1 1;...   % Rule 1
                1 2 2 1 1;...   % Rule 2
                2 1 2 1 1;...   % Rule 3
                2 2 1 1 1];     % Rule 4
FIS_CELEC = addRule(FIS_CELEC,ruleList);
