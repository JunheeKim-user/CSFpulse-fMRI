function y=fProcess2(targetdata,targetpath,savepath,calendar,resultShortsatSave)
realsavepath=savepath;
realtargetpath = targetpath;
realtargetdata = targetdata;

for cnt=1:length(realtargetdata)
    data1 = realtargetdata(cnt).name;
    cd([realsavepath '\' data1]);
    load([num2str(calendar) '_csf_preprocess.mat']);
    for itr = 1:length(slicelist)-2
        csf11 = csf_nsort(slicelist(itr),:); % target 1
        csf13 = csf_nsort(slicelist(itr+2),:); % target 2 (subsequent slice of slice1)
        target_slice1 = ['slice ' num2str(slicelist(itr))];
        target_slice2 = ['slice ' num2str(slicelist(itr+2))];
        
        %% CSF simul 다른방법, phillips도 같이 고려.
        
        interTR = round(TR/slicen);
        saveonoff=1;
        
        if round(TE/5)<2
            disp('ERROR::: TE should be longer than 15ms');
            return;
        end
        disp(['InterTR: ' num2str(interTR)]);
        shortsat=resultShortsatSave(round(TR/100),interTR,round(TE/5)-2);
        
        for idx=1:length(csf13)
            ratio2(idx) = (csf13(idx)-csf11(idx))/(csf11(idx)*shortsat-csf11(idx));
            if ratio2(idx)<0
                ratio2(idx)=0;
            end
        end
        
        if saveonoff
            save([realsavepath '\' data1 '\' num2str(calendar) '_preprocess' '_Analysis_save.mat']);
        end
        clear ratio2;
        
    end
    disp(['Processing 2... ' 'subj.' data1 ' finished']);
end

end