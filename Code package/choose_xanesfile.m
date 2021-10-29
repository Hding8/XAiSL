function choose_xanesfile(handles)

% global xrffilename;
global scxanes
global xanesfilename;
global xanespath;
[xanesfilename, xanespath]=uigetfile;
addornot=get(handles.xanesbox,'string');

cd(xanespath);

fid = fopen(xanesfilename);
      scxanes=0;
      while ~feof(fid)
       tline = fgetl(fid);
       Line=regexp(tline,'#  energy');
       scxanes=scxanes+1;
        if Line~=0
            Tit2=regexp(tline,'  ','split');
         break
        end
      end

[rt,colt]=size(Tit2);

if isempty(addornot)
      set(handles.xanesbox,'String',Tit2(:,3:colt));
    elseif addornot==Tit2(:,3:colt)
        set(handles.xanesbox,'String',Tit2(:,3:colt));
    else
    set(handles.xanesbox,'String',vertcat(addornot,Tit2(:,3:colt)));
    
end
