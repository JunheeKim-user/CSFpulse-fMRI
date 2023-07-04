function y=fProcess1(targetdata,targetpath,savepath,calendar)
realtargetpath = targetpath;
realtargetdata = targetdata;
calendartoday=calendar;
realsavepath = savepath;
for cnt = 1:length(realtargetdata)
    cd(realsavepath);
    data0 = realtargetdata(cnt).name;
    load([data0 '_prepare_save.mat']);
    TR=str2num(TR);TE=str2num(TE);FA=str2num(FA); slicen=40;
    calendar = calendartoday;
    resolutionx = niiinfo.PixelDimensions(1);
    resolutiony = niiinfo.PixelDimensions(2);
    t=(0:time_phase-1)*TR/1000;
    csf_roiset2(isnan(csf_roiset2))=0;
    epi_img(isnan(epi_img))=0;
    csf_roisetsort = csf_roiset2;
    
    clear csf_nsort temp;
    
    for sl=1:length(slicelist)
        for kk=1:size(epi_img,4)
            temp(:,:,sl,kk)=double(epi_img(:,:,slicelist(sl),kk)).*csf_roiset2(:,:,slicelist(sl));
        end
    end
    
    % temporal signal of ROI (average)
    for sl=1:slicen
        for time=1:size(epi_img,4)
            csf_nsort(sl,time)=sum(sum((double(epi_img(:,:,sl,time)).*csf_roiset2(:,:,sl))))/(sum(sum(csf_roiset2(:,:,sl)))+1e-7);
        end
    end
    if( ~exist([realsavepath '\' data0]) )   dos(['mkdir ' realsavepath '\' data0]); end;
    cd([realsavepath '\' data0]);
    save([num2str(calendar) '_csf_preprocess.mat'],'csf_nsort','slicelist', 'TR','TE','FA','slicen','csf_roisetsort','temp','resolutionx','resolutiony');
    
    disp(['Processing 1... ' 'subj.' data0 ' finished']);
end
end
