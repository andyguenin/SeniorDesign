clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set up these parameters
diameter_l = 1:1:10; % dm
weight_l = 1:1:50; %N
max_deformation_l = 1:1:30; % mm
time_l = 1:1:3 % sec

rest_deformation_l = 1:1:20; %mm


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Don't mess with tihs

g = 9.81; %m/s^2
rest_deformation_l = rest_deformation_l / 1000;
max_deformation_l = max_deformation_l / 1000;
diameter_l = diameter_l / 10;
time_l = time_l / 10;
clc;
close all;

disp 'starting simulation';

result = zeros(length(weight_l), length(max_deformation_l), length(time_l), length(diameter_l), length(rest_deformation_l), 3);

for weight_index = 1:length(weight_l)
    for def_index = 1:length(max_deformation_l)
       for time_index = 1:length(time_l)
           for dia_index = 1:length(diameter_l)
               for rest_dia_index = 1:length(rest_deformation_l)
                   weight = weight_l(weight_index);
                   def = max_deformation_l(def_index);
                   time = time_l(time_index);
                   diameter = diameter_l(dia_index);
                   rest_deformation = rest_deformation_l(rest_dia_index);

                   [k h p] = khp(weight, def, time, diameter, rest_deformation);

                   result(weight_index, def_index, time_index, dia_index, rest_dia_index, 1) = k;
                   result(weight_index, def_index, time_index, dia_index, rest_dia_index, 2) = h;
                   result(weight_index, def_index, time_index, dia_index, rest_dia_index, 3) = p;
               end
           end
       end
    end
end
while 1
   w = input(strcat('Choose a weight (N) between ', num2str(min(weight_l)), ' and ', num2str(max(weight_l)), '\n'));
   def = input(strcat('Choose a deformation (mm) between', ' ', num2str(min(max_deformation_l)*1000), ' ', 'and', ' ', num2str(1000*max(max_deformation_l)),'\n'));
   t = input(strcat('Choose a time (d*sec) between', ' ', num2str(10*min(time_l)), ' ', 'and', ' ', num2str(10*max(time_l)),'\n'));
   dia = input(strcat('Choose a diameter (m) between', ' ', num2str(10*min(diameter_l)), ' ', 'and', ' ', num2str(10*max(diameter_l)),'\n'));
   rest = input(strcat('Choose a rest deformation (mm) between', ' ', num2str(1000*min(rest_deformation_l)), ' ', 'and', ' ', num2str(1000*max(rest_deformation_l)),'\n'));
   k = result(w, def, t, dia, rest, 1)
   h = result(w, def, t, dia, rest, 2)
   p = result(w, def, t, dia, rest, 3)
end