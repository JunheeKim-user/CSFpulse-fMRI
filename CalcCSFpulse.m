function y=CalcCSFpulse(targetpath,savepath,name_sub,name_epi,TR,TE,FA,GoFlag1,GoFlag2)
nowtime_temp = datevec(datetime);
year = num2str(nowtime_temp(1));
if nowtime_temp(2)<10
    month = ['0' num2str(nowtime_temp(2))];
else
    month = num2str(nowtime_temp(2));
end
if nowtime_temp(3)<10
    day = ['0' num2str(nowtime_temp(3))];
else
    day = num2str(nowtime_temp(3));
end
calendar = str2num([year month day]); %#ok<ST2NM>
%% Data Scan, ROI set.
if GoFlag1
    fDataROIset(targetpath,savepath,name_sub,name_epi,TR,TE,FA);
end
%% After ROI setting, CSFpulse Processes..
if GoFlag2
    RFnum = 100;
    [resultSave, resultShortsatSave] = fEPI_CSF_simul(RFnum);
    
    fProcess1(name_sub,targetpath,savepath,calendar);
    fProcess2(name_sub,targetpath,savepath,calendar,resultShortsatSave);
    fProcess3(name_sub,targetpath,savepath,calendar);
    
    save2='CSFpulse_dynamic_raw_data';
    fCSFpulse_Raw(name_sub,targetpath,savepath,calendar,save2);
end

end

