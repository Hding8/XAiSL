function show_xanes(handles)
% if strcmp(get(handles.xrfelementbox,'selectiontype'),'open')
    global xanesfilename;
    global scxanes
    global difchar
    global xanespath;
    global Figu
    cd(xanespath);
    xanes=dlmread(xanesfilename,'',scxanes,0);
   
    value=get(handles.xanesbox,'value');
    valuereal=value+1;
   if size(valuereal)==1
    axes(handles.xrfaxes);
    plot(xanes(:,1),xanes(:,valuereal));
    Figu=figure(1);
    set(figure(1),'visible','off')
    plot(xanes(:,1),xanes(:,valuereal));
%   set(gca,'tickdir','out');
%     colormap jet;
%     colorbar;
   else
       difvalue=xanes(:,valuereal(2))-xanes(:,valuereal(1));
       difv=difvalue';
       [difmax,maxpos]=max(difv);
       [difmin,minpos]=min(difv);
%        Rangx=difmax-difmin;
       Sizx=size(difvalue);
       axes(handles.xrfaxes);
       plot(xanes(:,1),difvalue)
%        axis([min(xanes(:,1)) max(xanes(:,1)) difmin difmax]); 
%        rangmin2=[0.2 0.14];
% %        if minpos/Sizx(1)>0.5
%        rangmin=[(minpos-5)./Sizx(1) (minpos+15)./(Sizx(1)+20)];
% %        end 
%        rangmax2=[0.8 0.9];
%        rangmax=[(maxpos+20)./Sizx(1) (maxpos+15)./(Sizx(1)+20)];
       text(xanes(maxpos,1),difmax,'\leftarrow Max');
       text(xanes(minpos,1),difmin,'\leftarrow Min');
%        axes(handles.xrfaxes);
%        annotation('textarrow',rangmax,rangmax2,'String','MAX')
%        annotation('textarrow',rangmin,rangmin2,'String','MIN')
       Figu=figure(1);
       set(figure(1),'visible','off')
       plot(xanes(:,1),difvalue);
       text(xanes(maxpos,1),difmax,'\leftarrow Max');
       text(xanes(minpos,1),difmin,'\leftarrow Min');
%        axis([min(xanes(:,1)) max(xanes(:,1)) difmin difmax]); 
%        annotation('textarrow',rangmax,rangmax2,'String','MAX')
%        annotation('textarrow',rangmin,rangmin2,'String','MIN')
       difchar=zeros([2,2]);
       difchar(1,1)=max(difvalue);
       difchar(1,2)=min(difvalue);
%    difchar(2,1)=xanes(find(max(difvalue)),1);
%    difchar(2,2)=xanes(find(min(difvalue)),1);
   end


end