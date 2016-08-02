%% Programm for callibrating ce
close all;
clear all;
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

r_NA = 15;              % radius of condensers NA (63x entspricht 160 Pixel; 10x = 10
dAperture = 3;          % diameter of illumination spot
exposureTime =2500;     % exposure time in ms

delayTime = 0;         % Delay time between measurements

%% Declaration of Serial Port
com_port= 'COM3';
%com_port= 'COM18';
delete(instrfind({'Port'},{com_port}));
serial_port=serial(com_port);
serial_port.BaudRate=57600;
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');

%Open Serial Port
fopen(serial_port);
pause(2)

setLedPower(serial_port, 0);

%% Set global coordinates for centering
x_centre = (x_width/2)-30;  % smaller values shift pupil down
y_centre = (y_width/2)-30;  % smaller values shift pupil to right
setGlobalCentre( serial_port, x_centre, y_centre )

% %% test aperture settting brightfield
% setReset(serial_port);
% setBrightfield(serial_port, (20));%r_NA_px
% pause(4)
% setReset(serial_port);
% % break;


% define nine coordinates, centre + 8 in circle
rho = r_NA*ones(9,1)/2;
rho(1)=0;
theta = circshift(linspace(0,2*pi,9), [0 1])';

[X Y] = pol2cart(theta, rho);
disp('Start');
pause(2)
setLedPower(serial_port, 255);
pause(2)
driveFocus( serial_port, 200, -2000)
pause(2)
driveFocus( serial_port, 200, 2500)
pause(2)
pause(1)
for(j=1:15)
    driveFocus( serial_port, 150, -80)
    for ( i=1:size(theta,1))
        %% Send commands
        pause(.1);
        setScanAperture( serial_port, round((X(i) + x_centre)), round(Y(i) + y_centre), dAperture, exposureTime )    % show centre dot (0,0)
        pause(delayTime);
        disp(num2str(i))
        pause(.1);
    end
    
end
driveFocus( serial_port, 150, -1000)
setLedPower(serial_port, 0);


%% Close connection and reset
% fclose(serial_port);
% delete(serial_port);

