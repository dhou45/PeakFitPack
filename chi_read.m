
% Plots chi and xy files
% by Giovanni Esteves

close all;
clear intensity norm2 norm1;
% File Select
prompt='New File? '; %ask user if he/she is importing a new file 
answer=input(prompt,'s'); 

if exist('datapath','var')==1
    if strncmpi(answer,'y',1)==1 %if it is (Yes, Y, or y)then...
[filename, datapath]=uigetfile([datapath,'*.chi; *.xy'],'MultiSelect','on'); %will ask user to input a new file 
elseif strncmpi(answer,'1',1)==1
[filename, datapath]=uigetfile([datapath,'*.chi; *.xy'],'MultiSelect','on'); 
    end
else

A=strncmpi(answer,'y',1); %compares the asnwer inputed by the user 
C=strncmpi(answer,'1',1);
if A==1 %if it is (Yes, Y, or y)then...
[filename, datapath]=uigetfile('*.chi; *.xy','MultiSelect','on'); %will ask user to input a new file if no...program skips to line 42
elseif C==1
    [filename, datapath]=uigetfile('*.chi; *.xy','MultiSelect','on');
end
B=exist('filename','var'); % checks to see if the variable filename has been defined
if B~=1 %if B does not equal 1 which means, that there is no variable defined for filename then...
display('There is no existing file, please select'); %display the following
[filename, datapath]=uigetfile('*.chi; *.xy','MultiSelect','on'); %allows user to select file from computer
end

end
if isa(filename,'char')
filename = {filename};
end

for j=1:1:length(filename);
inFile = strcat(datapath, filename{j});    
openresults=fopen(inFile,'r');
xy=strsplit(filename{j},'.');
if strcmp(xy(2),'xy')~=1

for i=1:4;
fgetl(openresults);
end

else

end

results1=transpose(fscanf(openresults,'%f',[2 inf]));%opens the file listed above and obtains data in all 5 columns
twotheta=results1(:,1);
intensity(:,j)=results1(:,2);
end
fclose('all');
% dspace=0.11798./(2.*sind(twotheta/2));
dspace=1.22752000./(2.*sind(twotheta/2));

%% Raw
figure('Color','white')
hold on;
for p=1:length(filename)
ax1=plot(twotheta,intensity(:,p),'-o','MarkerSize',6,'LineWidth',1.5, 'MarkerFaceColor','auto');
end
set(gca,'Box','on','LineWidth',1.5,'XColor','black','YColor','black','FontSize',14,'FontName','Calibri','FontWeight','normal');
% plot(dspace,intensity,'--x','MarkerSize',10,'LineWidth',1.5);
set(gca,'Xlim',[min(twotheta) max(twotheta)]);
title('Raw')
xlabel('2Theta');
ylabel('Intensity');
legend(filename)
set(legend,'FontSize',10);
hold off;
%% Norm
nsiz=size(intensity);
for n=1:nsiz(2)
    norm1(:,n)=intensity(:,n)/max(intensity(:,n));
    norm2(:,n)=intensity(:,n)/trapz(twotheta,intensity(:,n));
end
figure('Color','white')
hold on
for p=1:length(filename)
ax2=plot(twotheta, norm1(:,p), 'LineWidth',1);
end
title('Normalized-MaxInt')
xlabel('2Theta');
ylabel('Intensity');
% for p=1:length(filename)
% ax2=plot(twotheta, norm2(:,p),'LineWidth',1);
% title('Normalized-IntegratedInt')
% end
set(gca,'Box','on','LineWidth',1.5,'XColor','black','YColor','black','FontSize',14,'FontName','Calibri','FontWeight','normal');
set(gca,'Xlim',[min(twotheta) max(twotheta)]);

legend(filename)
set(legend,'FontSize',10);
hold off
%% Contour
try
files=[];
for f=1:size(intensity,2)
    files(:,f)=f;
end
[FF,TT]=meshgrid(files,twotheta);
figure('Color','white')
ax3=contourf(TT,FF,intensity,200,'LineColor','None');
set(gca,'Box','on','LineWidth',1.5,'XColor','black','YColor','black','FontSize',14,'FontName','Calibri','FontWeight','normal');
set(gca,'CLim',[1500 5000]);
xlabel('2Theta');
ylabel('Intensity');
colormap('jet');
catch
    close figure 3
end
clearvars -except filename datapath pf1 intensity twotheta norm1 norm2 pressure ax1 ax2 ax3
