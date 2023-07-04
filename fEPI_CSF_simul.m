function [resultSave, resultShortsatSave]=fEPI_CSF_simul(RFnum)
%% EPI saturation effect
TRrepetition=42; % 100~4200
interTRrepetition=2000; % 1~2000 (1간격)
TErepetition=8; % 15~50 (5간격)
resultSave = zeros(TRrepetition,interTRrepetition,TErepetition,RFnum);
resultShortsatSave = zeros(TRrepetition,interTRrepetition,TErepetition,1);
    %%
disp('EPI CSF simulation START------------------');
for TRrep = 1:TRrepetition
    for interTRrep=1:interTRrepetition
        for TErep = 1:TErepetition
            TR=100*TRrep;
            interTR=interTRrep;
            TE=5*TErep+10;
            %%%%%% pulsation affected imaging slice signals %%%%%%%%%
            epiMt = fEPIa_shortTR(0,0,1,RFnum,1,TR,TE,interTR,4000,2030,90,0);
            epiSt = sqrt(epiMt(2,:).^2);
            shortsat = epiSt(end)/epiSt(end-1);

            resultSave(TRrep,interTRrep,TErep,:) = epiSt(1,:);
            resultShortsatSave(TRrep,interTRrep,TErep,1) = shortsat;
        end
    end
end
disp('EPI CSF simulation DONE------------------');
end