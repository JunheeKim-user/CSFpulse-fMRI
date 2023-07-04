function y=fCSFpulse_Raw(targetdata,targetpath,savepath,calendar,save2)
%% Save CSF pulsation metric (CSFpulse) in time course.
realtargetpath = targetpath;
realtargetdataq = targetdata;
isDir=0;
for sbjc=1:length(realtargetdataq)
    dataset = realtargetdataq(sbjc).name;
    
    cd([savepath '\' dataset]);
    analysis_list = dir(['*' num2str(calendar) '_preprocess_Analysis_save*']);
    for cnt3=1:length(analysis_list)
        isDir=isDir+1;
        load(analysis_list(cnt3).name);
        roiarea = sum(sum(csf_roisetsort(:,:,str2num(target_slice2(find(target_slice2==' ')+1:end)))))*(resolutionx*resolutiony);
        CSFpulsetemp(cnt3,:) = roiarea*ratio2;
    end
    if size(CSFpulsetemp,1) ~=1
        CSFpulse = mean(CSFpulsetemp);
    else
        CSFpulse = CSFpulsetemp;
    end
    
    if( ~exist([savepath '\' save2]) )   dos(['mkdir ' savepath '\' save2]); end;
    save([savepath '\' save2 '\' dataset '.mat'],'CSFpulse','CSFpulsetemp');
    disp(['Done....CSFpulse Raw. ' num2str(sbjc) '/' num2str(length(realtargetdataq))]);
end
end
