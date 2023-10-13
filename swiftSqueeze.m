axis([-20,20,-20,20,-20,20])

% ptCloud = pcread('lemon.ply');
% pcshow(ptCloud);

mesh = readSurfaceMesh('lemon.ply');

surfaceMeshShow(mesh);