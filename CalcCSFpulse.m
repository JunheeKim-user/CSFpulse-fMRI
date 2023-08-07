function y=CalcCSFpulse(targetpath,savepath,name_epi,TR,TE,FA,GoFlag1,GoFlag2)

%% Data Scan, ROI set.
if GoFlag1
    fDataROIset(targetpath,savepath,name_epi,TR,TE,FA);
end
%% After ROI setting, CSFpulse Processes..
format longG
t=now;
calendar = floor(t);
if GoFlag2
    RFnum = 100;
    [resultSave, resultShortsatSave] = fEPI_CSF_simul(RFnum);
    
    fProcess1(name_epi,targetpath,savepath,calendar);
    fProcess2(name_epi,targetpath,savepath,calendar,resultShortsatSave);
    fProcess3(name_epi,targetpath,savepath,calendar);
    
    save2='raw';
    fCSFpulse_Raw(name_epi,targetpath,savepath,calendar,save2);
end

end

