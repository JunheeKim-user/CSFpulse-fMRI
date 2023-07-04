function y=fProcess3(targetdata,targetpath,savepath,calendar)
%%
isDir=0;
realtargetdata0 = targetdata;
realtargetpath = targetpath;
realcalendar0 = calendar;
for sbjl0=1:length(realtargetdata0)
    dataset0 = realtargetdata0(sbjl0).name;
    cd([savepath '\' dataset0]);
    
    analysis_list0 = dir(['*' num2str(calendar) '_preprocess' '_Analysis_save*']);
    for cnt3=1:length(analysis_list0)
        isDir=isDir+1;
        load(analysis_list0(cnt3).name);
        ratio2_mean = mean(ratio2(1,5:end)); % Exclude first 5 measurements
        roiarea = sum(sum(csf_roisetsort(:,:,str2num(target_slice2(find(target_slice2==' ')+1:end)))))*(resolutionx*resolutiony);
        CSFpulse = roiarea*ratio2_mean;
        final(isDir).name=dataset0;
        final(isDir).csf11=mean(csf11);
        final(isDir).csf13=mean(csf13);
        final(isDir).ratio2_mean=ratio2_mean;
        final(isDir).roiarea = roiarea;
        final(isDir).CSFquant = CSFpulse;
        disp(['Processing 3... subj.' dataset0 ' finished']);
    end
    
end



%%%%%%%%%%%%%%% Save whole data as final  %%%%%%%%%%%
save([savepath '\' num2str(calendar) '_finalmerge.mat'],'final');
T=struct2table(final);
writetable(T, [savepath '\' num2str(calendar) '_finalmerge.xlsx']);

end