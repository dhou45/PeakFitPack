function Fit2DBatch 
% written by Giovanni Esteves
% This .m file writes a batch file for input into Fit2D for integrating a set of 2D diffraction images
% Modify the experimental details first then integration parameters
%% Fit2D Integration Parameters
% Experimental Details
% NOTE: PIXEL SIZE IS SET TO 200 MICRONS!!!
SDD=2199.25;                           %Sample to Detector Distance
Wavelength= 0.11798;                % Wavelength
XbeamCent=969.7696;                       % X-Pixel Center of Direct Beam
YbeamCent=1022.839;                       % Y-Pixel Center of Direct Beam
TRotation=173.1308;                             % Rotation Angle of Tilting Plane (Deg)
AngleTilt=-.312995;                            % Angle of Detector Tilt
% *Integration Parameters*
StartAzi=-5;
EndAzi=355;
Inner=280;
Outer=850;
AziBins=36;
RadialBins=1000;
Scan='2-THETA';
CHI='n'; % Change this to yes if you want .chi files if you select no then it outputs .spr

%% File Select
disp('Select files you want to add to batch file ')
[filename, datapath]=uigetfile('.tif','MultiSelect','on'); 
if isa(filename,'char')==1
    filename={filename};
end

file=strcat(datapath,filename);
for s=1:length(file)
sax=strsplit(file{s},'.');
sav(s)=strcat(sax(1),'.xy"');
end

%% Fit2D Generic Write
FileName=strcat(datapath,'Fit2DBatch.mac');
FileID=fopen(FileName,'w');
% Header and initial parameters for the first file
fprintf(FileID,'%s \n','%!*\ BEGINNING OF GUI MACRO FILE');
fprintf(FileID,'%s \n','%!*\');
fprintf(FileID,'%s \n','%!*\ This is a comment line);');
fprintf(FileID,'%s \n','%!*\');
fprintf(FileID,'%s \n','EXIT');
fprintf(FileID,'%s \n','POWDER DIFFRACTION (2-D)');
fprintf(FileID,'%s \n','INPUT'); 
fprintf(FileID,'%s \n',file{1});
fprintf(FileID,'%s \n','O.K.');
fprintf(FileID,'%s \n','O.K.');
fprintf(FileID,'%s \n','CAKE'); 
fprintf(FileID,'%s \n','INTEGRATE');
fprintf(FileID,'%s \n','X-PIXEL SIZE');
fprintf(FileID,'%s \n','200.0000');
fprintf(FileID,'%s \n','Y-PIXEL SIZE');
fprintf(FileID,'%s \n','200.0000');
fprintf(FileID,'%s \n','DISTANCE');
fprintf(FileID,'%s \n',num2str(SDD));
fprintf(FileID,'%s \n','WAVELENGTH');
fprintf(FileID,'%s \n',num2str(Wavelength));
fprintf(FileID,'%s \n','X-BEAM CENTRE');
fprintf(FileID,'%s \n',num2str(XbeamCent));
fprintf(FileID,'%s \n','Y-BEAM CENTRE');
fprintf(FileID,'%s \n',num2str(YbeamCent));
fprintf(FileID,'%s \n','TILT ROTATION');
fprintf(FileID,'%s \n',num2str(TRotation));
fprintf(FileID,'%s \n','ANGLE OF TILT');
fprintf(FileID,'%s \n',num2str(AngleTilt));
fprintf(FileID,'%s \n','O.K.');
fprintf(FileID,'%s \n','START AZIMUTH');
fprintf(FileID,'%s \n',num2str(StartAzi));
fprintf(FileID,'%s \n','END AZIMUTH');
fprintf(FileID,'%s \n',num2str(EndAzi));
fprintf(FileID,'%s \n','INNER RADIUS');
fprintf(FileID,'%s \n',num2str(Inner));
fprintf(FileID,'%s \n','OUTER RADIUS');
fprintf(FileID,'%s \n',num2str(Outer));
fprintf(FileID,'%s \n','SCAN TYPE');
fprintf(FileID,'%s \n',num2str(Scan));
fprintf(FileID,'%s \n','AZIMUTH BINS');
fprintf(FileID,'%s \n',num2str(AziBins));
fprintf(FileID,'%s \n','RADIAL BINS');
fprintf(FileID,'%s \n',num2str(RadialBins));
fprintf(FileID,'%s \n','MAX. D-SPACING');
fprintf(FileID,'%s \n','5.000000');
fprintf(FileID,'%s \n','O.K.');
fprintf(FileID,'%s \n','EXIT');
fprintf(FileID,'%s \n','OUTPUT');
if strcmp(CHI,'y')~=1
fprintf(FileID,'%s \n','SPREAD SHEET');
fprintf(FileID,'%s \n','YES');     
fprintf(FileID,'%s \n',strcat(datapath,filename{1}(1:end-3),'spr'));

else
fprintf(FileID,'%s \n','CHIPLOT');
fprintf(FileID,'%s \n','O.K.');  
end
fprintf(FileID,'%s \n','EXCHANGE');

% Repeats the following lines for subsequent files after the first one
for i=2:length(file)

fprintf(FileID,'%s \n','INPUT');
fprintf(FileID,'%s \n',file{i});
fprintf(FileID,'%s \n','O.K.');
fprintf(FileID,'%s \n','O.K.');
fprintf(FileID,'%s \n','CAKE');
fprintf(FileID,'%s \n','INTEGRATE');
fprintf(FileID,'%s \n','O.K.');
fprintf(FileID,'%s \n','O.K.');
fprintf(FileID,'%s \n','EXIT');
fprintf(FileID,'%s \n','OUTPUT');
if strcmp(CHI,'y')~=1
fprintf(FileID,'%s \n','SPREAD SHEET');
fprintf(FileID,'%s \n','YES');     
fprintf(FileID,'%s \n',strcat(datapath,filename{i}(1:end-3),'spr'));

else
fprintf(FileID,'%s \n','CHIPLOT');
fprintf(FileID,'%s \n','O.K.');
 
end

fprintf(FileID,'%s \n','EXCHANGE');


end

% Integrates a chi file with 1 AziBin to use for SPR
if strcmp(CHI,'y')~=1
fprintf(FileID,'%s \n','CAKE');
fprintf(FileID,'%s \n','INTEGRATE');
fprintf(FileID,'%s \n','O.K.');    
fprintf(FileID,'%s \n','AZIMUTH BINS');
fprintf(FileID,'%s \n','1');
fprintf(FileID,'%s \n','O.K.');
fprintf(FileID,'%s \n','EXIT');
fprintf(FileID,'%s \n','OUTPUT');
fprintf(FileID,'%s \n','CHIPLOT');
fprintf(FileID,'%s \n','O.K.');
end
% Writes the last three lines in the macro file to terminate it and return
% to macro window in Fit2D
fprintf(FileID,'%s \n','EXIT');
fprintf(FileID,'%s \n','MACROS / LOG FILE');
fprintf(FileID,'%s \n','%!*\ END OF IO MACRO FILE');

fclose all;
end