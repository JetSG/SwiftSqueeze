
x = KinovaLink6();%

z = 0; %pause timer



%%
for i = 0:0.1:2*pi
    x.model.animate([i, 0, 0, 0, 0, 0]);
    pause(z)
end
%%
for i = 0:0.1:2*pi
    x.model.animate([0, i, 0, 0, 0, 0]);
    pause(z)
end
%%
for i = 0:0.1:2*pi
    x.model.animate([0, 0, i, 0, 0, 0]);
    pause(z)
end
%%
for i = 0:0.1:2*pi
    x.model.animate([0, 0, 0, i, 0, 0]);
    pause(z)
end
%%
for i = 0:0.1:2*pi
    x.model.animate([0, 0, 0, 0, i, 0]);
    pause(z)
end
%%
for i = 0:0.1:2*pi
    x.model.animate([0, 0, 0, 0, 0, i]);
    pause(z)
end
%%

x.model.animate([0, 0, 0, 0, 0, 0]);
