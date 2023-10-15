%Arduino button testing 
clear all 

a = arduino('com3','Uno');
fig = uifigure;
b = uibutton(fig,"state", ...
    "Text","E-Stop", ...
        "IconAlignment","top", ...
    "Position",[100 100 50 50]);

while true
digibutton = b.Value;
buttonState = readDigitalPin(a,"D4");

if(buttonState == 1 || digibutton == 1)
   disp("button pressed")
else 
    disp("not pressed")
end 
end 