function M=fEPIa_shortTR(Mx0,My0,Mz0,nExt,nStartExt,TR,TE,shortTR,T1,T2,FAdeg,FreqOffset)
%% Simulate the multiple measurment of EPI CSF signal and more saturated signal at the last measurement
FA = FAdeg*pi/180; % radian
M0=1;

bettaTT=2*pi*FreqOffset*TE;
Dtt=[ exp(-TE/T2)*cos(bettaTT)  exp(-TE/T2)*sin(bettaTT)	0
    -exp(-TE/T2)*sin(bettaTT) exp(-TE/T2)*cos(bettaTT)      0
    0                       0                                exp(-TE/T1)];
bettaTR=2*pi*FreqOffset*TR;
bettaTR2=2*pi*FreqOffset*shortTR;

Dtr=[ exp(-TR/T2)*cos(bettaTR) exp(-TR/T2)*sin(bettaTR)     0
    -exp(-TR/T2)*sin(bettaTR) exp(-TR/T2)*cos(bettaTR)	0
    0                       0                             exp(-TR/T1)];
Dtr2=[ exp(-shortTR/T2)*cos(bettaTR2) exp(-shortTR/T2)*sin(bettaTR2)     0
    -exp(-shortTR/T2)*sin(bettaTR2) exp(-shortTR/T2)*cos(bettaTR2)	0
    0                       0                             exp(-shortTR/T1)];
if nStartExt>nExt
    disp('-- Error Msg: nStartExt > nExt --');
end
if nExt<1
    M=[Mx0;My0;Mz0];
else
    
    for i=nStartExt:nExt
        Rx0=[1 0 0; 0 cos(FA) sin(FA); 0 -sin(FA) cos(FA)];
        if( i == nStartExt )
            Mn0 = [Mx0; My0; Mz0];
            Mp0 = Rx0*Mn0;
            M(:,i)= Dtt*Mp0 + [0; 0; M0*(1-exp(-TE/T1))]; % acquired(observed) M
            Mn1   = Dtr*Mp0 + [0; 0; M0*(1-exp(-TR/T1))]; % M for next TR
        elseif i>=nExt-1 %i>=nExt-15 && i<nExt+14
            Mn0 = Mn1;
            Mp0 = Rx0*Mn0;
            M(:,i)= Dtt*Mp0 + [0; 0; M0*(1-exp(-TE/T1))]; % acquired(observed) M
            Mn1   = Dtr2*Mp0 + [0; 0; M0*(1-exp(-shortTR/T1))]; % M for next TR
        else
            Mn0 = Mn1;
            Mp0 = Rx0*Mn0;
            M(:,i)= Dtt*Mp0 + [0; 0; M0*(1-exp(-TE/T1))]; % acquired(observed) M
            Mn1   = Dtr*Mp0 + [0; 0; M0*(1-exp(-TR/T1))]; % M for next TR
        end

    end
end
end
