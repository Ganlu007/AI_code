clear;
delimiterIn   = ' '; 
headerlinesIn = 2;   
A = importdata('Li-mat.dat', delimiterIn, headerlinesIn);
%A = importdata('original_model.model', delimiterIn, headerlinesIn);

V=A.data;
X=[101.7 , 102.16, 102.43, 102.49, 102.87, 102.9 , 103.09, 103.3 ,...
       103.66, 103.69, 103.79, 104.  , 104.39, 104.4 , 104.88, 104.9 ,...
       104.95, 105.14, 105.2 , 105.79, 105.96, 106.21, 106.56, 106.63,...
       107.01, 107.03, 107.48, 107.5 , 107.88, 108.09, 108.38, 108.47,...
       108.7 , 108.77];

Z=[ 0.          0.75949367  1.51898734  2.27848101  3.03797468  3.79746835...
  4.55696203  5.3164557   6.07594937  6.83544304  7.59493671  8.35443038...
  9.11392405  9.87341772 10.63291139 11.39240506 12.15189873 12.91139241...
 13.67088608 14.43037975 15.18987342 15.94936709 16.70886076 17.46835443...
 18.2278481  18.98734177 19.74683544 20.50632911 21.26582278 22.02531646...
 22.78481013 23.5443038  24.30379747 25.06329114 25.82278481 26.58227848...
 27.34177215 28.10126582 28.86075949 29.62025316 30.37974684 31.13924051...
 31.89873418 32.65822785 33.41772152 34.17721519 34.93670886 35.69620253...
 36.4556962  37.21518987 37.97468354 38.73417722 39.49367089 40.25316456...
 41.01265823 41.7721519  42.53164557 43.29113924 44.05063291 44.81012658...
 45.56962025 46.32911392 47.08860759 47.84810127 48.60759494 49.36708861...
 50.12658228 50.88607595 51.64556962 52.40506329 53.16455696 53.92405063...
 54.6835443  55.44303797 56.20253165 56.96202532 57.72151899 58.48101266...
 59.24050633 60.  ]; 




%[X,Z]=meshgrid(X,Z);
Xi=101.6:0.01:108.8;
Zi=0:0.2:60;
[Xi,Zi]=meshgrid(Xi,Zi);
%Vi=interp2(X,Z,V,Xi,Zi,'cubic');
Vi=griddata(X,Z,V,Xi,Zi,'cubic');

H=fspecial('disk',8);
Vi=imfilter(Vi,H);
%s=surf(Xi,Yi,Zi,abs(Si));

s=pcolor(Xi,Zi,Vi);
set(s, 'LineStyle','none');
set(gca, 'ydir', 'reverse'); 
caxis([2.5,4.7])
%colormap jet
%colormap(flipud(jet))

mcolor=load('c1.mat');
mcolor=mcolor.c;
hmap=colormap(mcolor);

ch = colorbar('horiz');
%set(get(ch,'title'),'string','Velocity(m/s)');

% hbar=colorbar;
% hf=gca;
% c=hf.Colormap;
% save c1 c


set (gcf,'Position',[500,300,1290,680]) ;
set(gca,'FontSize',22,'Fontwei','Bold','Linewidth',1,'GridAlpha',.5);
set(gca,'YLim',[-10 59]);
set(gca,'XLim',[101.8 108.7]);
xlabel('Longitude (°)','FontName','Times New Roman','FontSize',25);
ylabel('Depth (km)','FontName','Times New Roman','FontSize',25)
hold on;

dat = load('pospick.txt');
X = dat(:,1);
Y = dat(:,2);
D = zeros(size(X));
k = length(X);
x1=113.108;
y1=41.6443;
for i = (1:k)
  D(i)=distance(y1,x1,Y(i),X(i))*111;
  plot(D(i),-3,'v','LineWidth',5,'color','k');
end


%axis off;
pbaspect([3.5 1 0.6])
saveas(gcf,'inv.jpg')

