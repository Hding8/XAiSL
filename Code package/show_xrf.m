function show_xrf(handles)
% if strcmp(get(handles.xrfelementbox,'selectiontype'),'open')
    global choosexrf;
    global trans;
    global xrffilepath;
    global Figu
    cd(xrffilepath)
    xrf=dlmread(choosexrf,'',2,0);
    value=get(handles.xrfelementbox,'value');
    valuereal=value+trans;
    
    XRDY=xrf(:,1);
    XRDX=xrf(:,2); 
    axes(handles.xrfaxes);
    if size(valuereal)==1 
    scatter(XRDX, XRDY, 60 , xrf(:,valuereal) ,'s', 'filled');
    axis off;
%   set(gca,'tickdir','out');
    colormap jet;
    colorbar;
    Figu=figure(1);
    set(figure(1),'visible','off')
    scatter(XRDX, XRDY, 60 , xrf(:,valuereal),'s', 'filled');
    axis off;
%   set(gca,'tickdir','out');
    colormap jet;
    colorbar;
    
    else
        Sizxrf=size(XRDX);
     colour=zeros([Sizxrf(1),3]);
     colour(:,1)=normalize(xrf(:,valuereal(1)),'range');
     colour(:,2)=normalize(xrf(:,valuereal(2)),'range');
     scatter(XRDX, XRDY, 60 , colour,'s', 'filled');
     axis off;
     set(gca,'tickdir','out');
     Figu=figure(1);
     set(figure(1),'visible','off')
     scatter(XRDX, XRDY, 60 , colour,'s', 'filled');
     axis off;
     set(gca,'tickdir','out');
    end
    
    
    

    
end