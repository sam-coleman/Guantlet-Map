%Take Data from collectData.m and create the gauntlet map

load('data_lidar')

%location of objects with respect to LIDAR frame L
%row 1 goes with row 5, 2 with 6, 3 with 7, 4 with 8
r_L = [r_all(:,1:end).*cos(theta_all(:, 1:end)), r_all(:,1:end).*sin(theta_all(:,1:end))]';


%location of objects with respect to Neato frame N
%need to subtract .084 from rows 1-4 of r_L and keep rows 5-8 the same
r_N = [r_L(1:4, :) - .084; r_L(5:end, :)];

%location of objects with respect to Global frame G
