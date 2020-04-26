%Take Data from collectData.m and create the gauntlet map

load('data_lidar')

%location of objects with respect to LIDAR frame L
%row 1 goes with row 5, 2 with 6, 3 with 7, 4 with 8
r_L = [r_all(:,1:end).*cos(theta_all(:, 1:end)), r_all(:,1:end).*sin(theta_all(:,1:end))]';

%location of objects with respect to Neato frame N
%need to subtract .084 from rows 1-4 of r_L and keep rows 5-8 the same
r_N = [r_L(1:4, :) - .084; r_L(5:end, :)];

%location of objects with respect to Global frame G
%iterate through each of the 4 starting places of Neato, and find the
%position data relative to the global frame
for n = 1:4 %n is the 4 placements of the Neato
    x = pos_head_all(n, 1);
    y = pos_head_all(n, 2);
    cos_phi = pos_head_all(n, 3);
    sin_phi = pos_head_all(n, 4);
    
    %Translation Matrix to go from Neato Frame to Global Frame
    T_GN = [1 0 x; 0 1 y; 0 0 1];
    
    %Rotation Matrix to go from Neato Frame to Global Frame
    R_GN = [cos_phi -sin_phi 0; sin_phi cos_phi, 0; 0 0 1];
    
    %assign the position matrix to use and do the transformation to make
    %Neato Frame into Global Frame
    if n == 1
        r_N_pos = [r_N(1, :); r_N(5, :); ones(1, 360)];
        r_N_pos1 = T_GN * R_GN * r_N_pos;
        r_N_pos1 = r_N_pos1(1:2, :);
    elseif n == 2 
        r_N_pos = [r_N(2, :); r_N(6, :); ones(1, 360)];
        r_N_pos2 = T_GN * R_GN * r_N_pos;
        r_N_pos2 = r_N_pos2(1:2, :);
    elseif n == 3
        r_N_pos = [r_N(3, :); r_N(7, :); ones(1, 360)];
        r_N_pos3 = T_GN * R_GN * r_N_pos;
        r_N_pos3 = r_N_pos3(1:2, :);
    elseif n == 4
        r_N_pos = [r_N(4, :); r_N(8, :); ones(1, 360)];
         r_N_pos4 = T_GN * R_GN * r_N_pos;
        r_N_pos4 = r_N_pos4(1:2, :);
    end
end
%concatante into one big matrix
r_N_all = [r_N_pos1; r_N_pos2; r_N_pos3; r_N_pos4];

%Plot the map!!
figure(), clf
hold on
plot(r_N_all(1, :), r_N_all(2, :), '*')
plot(r_N_all(3, :), r_N_all(4, :), '*')
plot(r_N_all(5, :), r_N_all(6, :), '*')
plot(r_N_all(7, :), r_N_all(8, :), '*')
title('Map of Gauntlet')
xlabel('Distance (m)')
ylabel('Distance (m)')
hold off