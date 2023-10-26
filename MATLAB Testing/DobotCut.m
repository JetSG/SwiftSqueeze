Dobot = DobotMagician();
numSteps = 50;

lemonPos = [0.3, 0, 0.2];

cutStartPos = [0.12, 0, 0.38]; %will be replaced with lemonPos minus relevant values


[faceData,vertexData] = plyread('lemon.ply','tri');
faces = {[], faceData};
vertices = {[], vertexData};

T_end_effector = transl(0, 0, 0) * trotx(pi/2);
% Get the current robot end effector's pose
current_pose = Dobot.model.fkine(Dobot.model.getpos()).T;

% Apply the end effector's transformation
new_pose = current_pose * T_end_effector;


% Apply the new pose to the PLY model
transformed_vertices = new_pose * [vertices; ones(1, size(vertices, 2))];
% brickmesh(i).Vertices = brickmesh(i).Vertices + [0,0,-0.2];

% Plot the robot with the attached end effector
figure;
hold on;
trisurf(faces, transformed_vertices(1, :), transformed_vertices(2, :), transformed_vertices(3, :));
axis equal;




for i = 1:10

    animateDobot(cutStartPos, numSteps, Dobot)
    
    animateDobot(lemonPos, numSteps, Dobot)
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