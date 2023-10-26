figure;
workspace = [-3, 3, -5, 2.5, -3, 3];
q = [0,pi/4,pi/4,0,0];
% axis equal
hold on;


%       messing with settings
% [f, v, data] = plyread(tableV3.ply, 'tri');
% vertexColors = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
% tableMesh = patch('Vertices', v, 'Faces', f, 'FaceVertexCData', vertexColors, 'FaceColor', 'interp', 'EdgeColor', 'none');
% hold on;
% tableMesh.Vertices = tableMesh.Vertices + [0,0,-0.39];


table = PlaceObject('tableV3.ply', [0 0 0]);
lemon1 = PlaceObject('lemon1.ply', [0.005, 0.5, 0.775]);
lemon2 = PlaceObject('lemon2.ply', [0.005, 0.5, 0.775]);

camlight;

dobot = DobotMagician();

desiredBaseTr = transl(1.5016, 0.1834, 0.775);

dobot.model.base = desiredBaseTr * trotz(pi);

dobot.model.animate(dobot.model.getpos());


% kinova = KinovaLink6();
% 
% desiredBaseTr = transl(0.5434, 0.500, 0.775);
% 
% kinova.model.base = desiredBaseTr;
% 
% kinova.model.animate(dobot.model.getpos());

view(3);






numSteps = 50;
cuttingBoardPos = [1.160, 0.218, 0.775];

cutEndPos = [0, 0, 0] + cuttingBoardPos;

cutStartPos = [0, 0, 0.28] + cuttingBoardPos; %will be replaced with lemonPos minus relevant values

for i = 1:10

    animateDobot(cutStartPos, numSteps, dobot)
    
    animateDobot(cutEndPos, numSteps, dobot)
end 


function animateDobot(position, steps, Dobot)
    lemonPosikcon = Dobot.model.ikcon(transl(position));
    
    jointTrajectory = jtraj(Dobot.model.getpos(), lemonPosikcon, steps);
    
    for j = 1:steps
        q = jointTrajectory(j, :); % Get joint configuration for the current step
        Dobot.model.animate(q); % Animate the robot
        drawnow();
    end
end 
