% Code below is modified from the starter code provided by QEA Course Instructors
% Source Code can be found at: https://qeacourse.github.io/RoboNinjaWarrior/Sample_code/collectScans

sub = rossubscriber('/scan');

% place Neato at the origin pointing in the ihat_G direction
x1 = 0;
y1 = 0;
head_x1 = 1;
head_y1 = 0;
placeNeato(x1,y1,head_x1,head_y1)

% wait a while for the Neato to fall into place
pause(2);

% Collect data at the room origin
scan_message = receive(sub);
r_1 = scan_message.Ranges(1:end-1);
theta_1 = deg2rad([0:359]');

% place Neato at the origin pointing in a different direction
phi = pi/3;
x2 = 0;
y2 = 0;
head_x2 = cos(phi);
head_y2 = sin(phi);

placeNeato(0,0,head_x2,head_y2)

% wait a while for the Neato to fall into place
pause(2);

% Then collect data for the second location
scan_message = receive(sub);
r_2 = scan_message.Ranges(1:end-1);
theta_2 = deg2rad([0:359]');

% place Neato at a new position (a,b)_G with ihat_N oriented parallel to ihat_G
x3 = 1;
y3 = -3;
head_x3 = 1;
head_y3 = 0;
placeNeato(x3,y3,head_x3,head_y3)

% wait a while for the Neato to fall into place
pause(2);

scan_message = receive(sub);
r_3 = scan_message.Ranges(1:end-1);
theta_3 = deg2rad([0:359]');

% place Neato at an arbitrary position and orientation
phi = pi/6;
x4 = -1;
y4 = -2;
head_x4 = cos(phi);
head_y4 = sin(phi);
placeNeato(x4,y4,head_x4,head_y4)

% wait a while for the Neato to fall into place
pause(2);

scan_message = receive(sub);
r_4 = scan_message.Ranges(1:end-1);
theta_4 = deg2rad([0:359]');

% Shove everything into a matrix (you can use the matrix or the
% individual r_x and theta_x variables
r_all = [r_1 r_2 r_3 r_4];
theta_all = [theta_1 theta_2 theta_3 theta_4];

%position 1 is row 1 col 1-4, position 2 is row 2 col 1-4, etc
pos_head_all = [x1 y1 head_x1 head_y1; x2 y2 head_x2 head_y2; x3 y3 head_x3 head_y3; x4 y4 head_x4 head_y4];

%save variables to mat file to use in other function
save('data_lidar', 'r_all', 'theta_all', 'pos_head_all')