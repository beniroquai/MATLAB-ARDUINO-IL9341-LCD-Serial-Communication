%% Programm for callibrating ce
close all;
clear all;
clc;

x_width = 240;
y_width = 320;

x_centre = (x_width/2);
y_centre = (y_width/2);

r_NA = 160;              % radius of condensers NA (63x entspricht 160 Pixel; 10x = 10
r_NA = 80;
dAperture = 2;          % diameter of illumination spot
exposureTime = 5000;     % exposure time in ms

delayTime = 0;         % Delay time between measurements

%% Declaration of Serial Port
com_port= 'COM8';
delete(instrfind({'Port'},{com_port}));
serial_port=serial(com_port);
serial_port.BaudRate=57600;
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');

%Open Serial Port
fopen(serial_port);
pause(2)

%% Set global coordinates for centering
x_centre = (x_width/2)+0;  % smaller values shift pupil down
y_centre = (y_width/2)+10;  % smaller values shift pupil to right
setGlobalCentre( serial_port, x_centre, y_centre )

% %% test aperture settting brightfield
% setReset(serial_port);
% setBrightfield(serial_port, round(r_NA/2));
% pause(4)
% setReset(serial_port);


% define nine coordinates, centre + 8 in circle
rho = r_NA*ones(9,1)/2;
rho(1)=0;
theta = circshift(linspace(0,2*pi,9), [0 1])';

[X Y] = pol2cart(theta, rho);

pause(2);
disp(0)
for ( i=1:9)
%% Send commands
pause(.1);
xval = round((X(i) + x_centre));
yval =  round(Y(i) + y_centre);
setScanAperture( serial_port, xval, yval, dAperture, exposureTime )    % show centre dot (0,0)
pause(delayTime);
disp(num2str(i))
pause(.1);
end

%% Close connection and reset
% fclose(serial_port);
% delete(serial_port);

