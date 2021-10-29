function choose_xrdfile(handles)
    global Figu
[xrdfilename,xrdpath]=uigetfile;
cd(xrdpath);
dset=h5read(xrdfilename,'/entry/data/data');
xrdname=xrdfilename(1:end-3);
set(handles.listboxxrd,'string',xrdname);
% Load 2 theta range
theta=h5read(xrdfilename,'/entry/data/2-theta');
[thetasize,~]=size(theta);
% Load Colum range
Colu=h5read(xrdfilename,'/entry/data/col');
[col,~]=size(Colu);
% Load row range
Row=h5read(xrdfilename,'/entry/data/row');
[row1,~]=size(Row);
% Total XRD
total=zeros([thetasize,1]);

for i=1:col
  for  j=1:row1
          total=total+dset(:,i,j);
  end
end
axes(handles.xrfaxes);
plot(theta,total);
Figu=figure(1);
set(figure(1),'visible','off')
plot(theta,total);