function show_xrfelement(handles)
% if strcmp(get(handles.xrfelementbox,'selectiontype'),'open')
global choosexrf;
global trans;
global xrffilepath;

value=get(handles.xrfbox,'value');
string1=get(handles.xrfbox,'string');
string11=[string1,'.txt'];
string2=cellstr(string11);
choosexrf=string2{value};
cd(xrffilepath);
fid=fopen(choosexrf);
line_title=fgetl(fid); 
Tit=regexp(line_title,'	','split');
expre='ROI';
matches=regexp(Tit,expre);
[rt,colt]=size(Tit);


% [xrfl,xrfw]=size(xrf);

% XRFsum=zeros(xrfl,colt);
% k=1;
am=0;
Startcol=50;
for i=1:colt
if matches{i}==1
    am=am+1;
    
%     
%     str_var=Tit{i};
%     eval([str_var,'=xrf(:,i)']);
    if Startcol>i
        Startcol=i;
    end
end
end

trans=Startcol-1;
set(handles.xrfelementbox,'String',Tit(:,Startcol:Startcol+am-1));
