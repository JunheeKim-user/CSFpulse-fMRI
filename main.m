%% Supplemental CODE for CSFpulse calculation from EPI fMRI data
% Kim, J. H., Im, J. G., & Park, S. H. (2022). Measurement of CSF pulsation from EPI-based human fMRI. Neuroimage, 257, 119293.
%
% The data type can be either nii or Nifti.
% These codes are running based on Matlab 2020a.
% Manual processes are needed to specify 4th ventricle pair slices and set the CSF ROIs on those slices.

% Expected dataset (.nii or .Nifti) dimension: [Row, Column, Number of slice, Measurements]
% We recommend to use EPI fMRI dataset with ascending, interleaved slice order. 
% (ex. acquired slice order: 1,3,5,7...2,4,6,8,...)
% If the data was not acquired with interleaved order by various reasons, 
% you may have to adjust the interTR calculation part in fProcess2 function, or
% you may choose two pairs of target slices carefully again so that those slices have a subsequent relationship with each other.
% Furthermore, we recommend to use non-SMS accelerated EPI dataset.

% E-mail to Contact: bluejoon2016@gmail.com

%% Initialization
clear; close all; clc;
addpath(pwd);
temp = inputdlg('Enter the directory of dataset');
% ex. In case of Samle dataset, enter  C:\Sample
targetpath = temp{1};
addpath(targetpath);
cd(targetpath);

temp = inputdlg('Enter the name or common keyword of Subjects (ex. enter "sub" when the dataset aligned with sub1, sub2, sub3...)');
% ex. In case of Samle dataset, enter  sub
key = temp{1};
name_sub = dir(['*' key '*']);

temp = inputdlg('Enter the name or common keyword of fMRI-EPI nii dataset(s) (~"keyword"~.nii)');
% ex. enter "func" when only the fMRI-EPI dataset's name commonly includes keyword "func"
key = temp{1};
name_epi = key;


temp = inputdlg('Enter the directory where you want to save the processed data');
savepath = temp{1};

temp = inputdlg('What is the TR of the data? (ms)');
TR = str2num(temp{1});
temp = inputdlg('What is the TE of the data? (ms)');
TE = str2num(temp{1});
temp = inputdlg('What is the flip angle of the data? (degree)');
FA = str2num(temp{1});
%% Process CSFpulse from EPI-fMRI(nii or Nifti) data and Save the result.

GoFlag1 = 1; % For Data Scanning and setting the ROIs
GoFlag2 = 1; % CSFpulse processing
CalcCSFpulse(targetpath,savepath,name_sub,name_epi,TR,TE,FA,GoFlag1,GoFlag2);
