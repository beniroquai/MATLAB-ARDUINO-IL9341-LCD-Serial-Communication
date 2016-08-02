%% Programm for callibrating ce
close all;
% clear all;
clc;

x_width = 240;
y_width = 320;

x_centre = (x_width/2);
y_centre = (y_width/2);


d_NA = 30.5;            % diameter of condensers aperture

activearea_LCD = [33.84 45.12];                     % Setup active area of LCD-Screen
pixelnumber_LCD = [240 320];                            % Number of pixels in X/Y-Direction
pixelsize_LCD = mean(activearea_LCD./pixelnumber_LCD);	% Pixelsize of LCD

r_NA_px = round(0.5*d_NA/pixelsize_LCD);

r_NA = 60;              % radius of condensers NA (63x entspricht 160 Pixel; 10x = 10
dAperture = 5;          % diameter of illumination spot
exposureTime = 2500;     % exposure time in ms

delayTime = 0;         % Delay time between measurements

%% Declaration of Serial Port
com_port= 'COM7';
delete(instrfind({'Port'},{com_port}));
serial_port=serial(com_port);
serial_port.BaudRate=57600;
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');

%Open Serial Port
fopen(serial_port);
pause(2)

%% Set global coordinates for centering
x_centre = (x_width/2)-2;  % smaller values shift pupil down
y_centre = (y_width/2)+2;  % smaller values shift pupil to right
setGlobalCentre( serial_port, x_centre, y_centre )

% %% test aperture settting brightfield
% setReset(serial_port);
% setBrightfield(serial_port, (90));%r_NA_px
% pause(4)
setReset(serial_port);


% define nine coordinates, centre + 8 in circle
rho = r_NA*ones(9,1)/2;
rho(1)=0;
theta = circshift(linspace(0,2*pi,9), [0 1])';

[X Y] = pol2cart(theta, rho);


radius = 50;
angle = 1;

rNAi = 0;
rNAo = 108;



for(i=[1 3 2 4])
setSemiCircleFast( serial_port, rNAo, rNAi, round(90*i))
i
pause(3);
end



%% Close connection and reset
% fclose(serial_port);
% delete(serial_port);

