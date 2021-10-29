function choose_xrffile(handles)

% global xrffilename;

global xrffilename;

global xrffilepath;

[xrffilename , xrffilepath]=uigetfile;
addornot=get(handles.xrfbox,'string');
xrfname=xrffilename(1:end-4);
if isempty(addornot)
      set(handles.xrfbox,'String',xrfname);
    elseif addornot==xrfname
        set(handles.xrfbox,'String',xrfname);
    else
    set(handles.xrfbox,'String',vertcat(addornot,xrfname));
    
end
cd(xrffilepath);



% set(handles.xrfelementbox,'String',Tit{Startcol:Startcol+am-1});