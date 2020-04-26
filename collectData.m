% Code below is modified starter code provided by QEA Course Instructors
% Source Code can be found at: https://qeacourse.github.io/RoboNinjaWarrior/Sample_code/collectScans

sub = rossubscriber('/scan');

% place Neato at the origin pointing in the ihat_G direction
placeNeato(0,0,1,0)

% wait a while for the Neato to fall into place
pause(2);

% Collect data at the room origin
scan_message = receive(sub);
r_1 = scan_message.Ranges(1:end-1);
theta_1 = deg2rad([0:359]');

% place Neato at the origin pointing in a different direction
phi = pi/3;
placeNeato(0,0,cos(phi),sin(phi))

% wait a while for the Neato to fall into place
pause(2);

% Then collect data for the second location
scan_message = receive(sub);
r_2 = scan_message.Ranges(1:end-1);
theta_2 = deg2rad([0:359]');

% place Neato at a new position (a,b)_G with ihat_N oriented parallel to ihat_G
placeNeato(1,-3,1,0)

% wait a while for the Neato to fall into place
pause(2);

scan_message = receive(sub);
r_3 = scan_message.Ranges(1:end-1);
theta_3 = deg2rad([0:359]');

% place Neato at an arbitrary position and orientation
phi = pi/6;
placeNeato(-1,-2,cos(phi),sin(phi))

% wait a while for the Neato to fall into place
pause(2);

scan_message = receive(sub);
r_4 = scan_message.Ranges(1:end-1);
theta_4 = deg2rad([0:359]');

% Shove everything into a matrix (you can use the matrix or the
% individual r_x and theta_x variables
r_all = [r_1 r_2 r_3 r_4];
theta_all = [theta_1 theta_2 theta_3 theta_4];

%save variables to mat file to use in other function
save('data_lidar', 'r_all', 'theta_all')