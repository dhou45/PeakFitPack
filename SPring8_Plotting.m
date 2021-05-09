frame_start = 1;
frame_end = 1500;
imagenum=0;

load('GR.mat');
GR_Sub= m([1 102:1002],[1 frame_start+1:frame_end+1]);

Y= GR_Sub(1,2:end);
X= GR_Sub(2:end, 1);
Z= GR_Sub(2:end, 2:end);
X1_GR = X(:);
Y1_GR = Y(:);
Z1_GR=Z';



imagenum=imagenum+1;
figure(imagenum);

contourf(X1_GR,Y1_GR,Z1_GR,100,'LineColor','none');
%contourf(X1_GR,Y1_GR,normZ1_GR,100,'LineColor','none');
colormap jet

set(gcf, 'PaperPositionMode', 'manual');
set(gcf,'PaperUnits','centimeters');
set(gcf,'PaperSize',[8.5 5]);
set(gcf,'PaperPosition',[0 0 8.5 5]);
grid off
set(gca,'fontsize',8);


xlabel('r (\(\AA\))','Interpreter','latex','FontSize',8);
ylabel('Scan Number','FontSize',8);
set(gca,'zticklabel',[]);
set(gca,'YLim',[min(Y1_GR) max(Y1_GR)]);
set(gca,'XLim',[min(X1_GR) max(X1_GR)]);

colorbar('SouthOutside','position',[0.80 0.02 0.15 0.03],'AxisLocation','out','FontSize',6);

print(sprintf('FIG.%d.tiff', imagenum),'-dtiff','-r600');

print(sprintf('FIG.%d_colorscaled.tiff', imagenum),'-dtiff','-r600');


frame_start = 1;
frame_end = 1500;

load('FQ.mat');
FQ_Sub= m(:,[1 frame_start+1:frame_end+1]);


Y= FQ_Sub(1,2:end);
X= FQ_Sub(2:end, 1);
Z= FQ_Sub(2:end, 2:end);
X1_FQ = X(:);
Y1_FQ = Y(:);
Z1_FQ=Z';


imagenum=imagenum+1;
figure(imagenum);

contourf(X1_FQ,Y1_FQ,Z1_FQ,100,'LineColor','none');
% contourf(X1_FQ,Y1_FQ,normZ1_FQ,100,'LineColor','none');
colormap jet

set(gcf, 'PaperPositionMode', 'manual');
set(gcf,'PaperUnits','centimeters');
set(gcf,'PaperSize',[8.5 5]);
set(gcf,'PaperPosition',[0 0 8.5 5]);
grid off
set(gca,'fontsize',8);


xlabel('Q (\(\AA^{-1}\))','Interpreter','latex','FontSize',8);
ylabel('Scan Number','FontSize',8);
colorbar('SouthOutside','position',[0.80 0.02 0.15 0.03],'AxisLocation','out','FontSize',6);

print(sprintf('FIG.%d.tiff', imagenum),'-dtiff','-r600');

print(sprintf('FIG.%d_colorscaled.tiff', imagenum),'-dtiff','-r600');

print(sprintf('FIG.%d_zoomed.tiff', imagenum),'-dtiff','-r600');

