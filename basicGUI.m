handles.fig=figure;
handles.pb1=uicontrol('style','pushbutton','position',[100 100 80 40],'callback',@start_cb,'string','Start');
handles.pb2=uicontrol('style','pushbutton','position',[200 100 80 40],'callback',@stop_cb,'string','Stop');
handles.run=1;
guidata(handles.fig,handles)
function start_cb(hObj,~)
while true
    handles=guidata(hObj);
    if handles.run==1
    disp('running')
    pause(1)
    else
        handles.run=1;
        guidata(hObj,handles)
        disp('stopped')
        break
    end
end
end

function stop_cb(hObj,~)
handles.run=0;
guidata(hObj,handles)
end