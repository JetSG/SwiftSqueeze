
x = KinovaLink6();%

figure(); 
%%
x.model.plot([ pi/2, 0, 0, 0, 0, 0], 'scale', 0.5, '[no]tiles', '[no]name')
%%
x.model.plot([0,  pi/2, 0, 0, 0, 0], 'scale', 0.5)
%%
x.model.plot([0, 0, pi/2, 0, 0, 0], 'scale', 0.5)
%%
x.model.plot([0, 0, 0,  pi/2, 0, 0], 'scale', 0.5)
%%
x.model.plot([0, 0, 0, 0, pi/2, 0], 'scale', 0.5)
%%
x.model.plot([0, 0, 0, 0, 0,  pi/2], 'scale', 0.5)
%%