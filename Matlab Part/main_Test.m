% Matlab + Arduino Serial Port communication
% Sending Zernike Polynomials to Arduino

close all;
clear all;
clc;

x_width = 240;
y_width = 320;

x_centre = (x_width/2)+50;
y_centre = (y_width/2)-20;


NAi_Diameter = 40; % Pixeldiameter of inner Condenser aperture
NAo_Diameter = 50; % Pixeldiameter of outer Condenser aperture

%Declaration of Serial Port
com_port= 'COM8';
delete(instrfind({'Port'},{com_port}));
serial_port=serial(com_port);
serial_port.BaudRate=57600;
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');

%Open Serial Port
fopen(serial_port); 
pause(2)

% Set global coordinates for centering
setGlobalCentre( serial_port, x_centre, y_centre )

% Set annullus for phase contrast
setPhaseContrast( serial_port, NAi_Diameter , NAo_Diameter)

% Reset display to black-state
setReset(serial_port);

% Set NA for brightfield
setBrightfield( serial_port, 55)

% Reset display to black-state
setReset(serial_port);


xi = 150;
yi = 290;
exposureTime = 10;
dAperture = 5;

NA = 30; % specify the illuminated area of the condenser NA in px
xNAcentre = x_centre;
yNAcentre = y_centre;

stepSize = 1;




for (xi=0:stepSize:x_width)
    for (yi=0:stepSize:y_width)        
        if(  abs((xi-xNAcentre)^2+(yi-yNAcentre)^2)<NA^2)
        setScanAperture( serial_port, xi , yi, dAperture, exposureTime )
        end
    end
end

%Wait until Arduino is ready for communication
result = 0;
while(result~=-1.0)
    result=fscanf(serial_port,'%d')  
end

pause(.5)


%Setup NA_Diameter
fprintf(serial_port,'I'); %sends command for NAi_Diameter
data = sprintf('%c%c', NAi_Diameter, NAi_Diameter);
fprintf(serial_port, data); %sends string via serial

pause(0.5); % Arduino needs some time until data is processed!


%Setup NAo_Diameter
%NAo_Diameter = 16; % Pixeldiameter of outer Condenser aperture
fprintf(serial_port,'O'); %sends command for NAi_Diameter
data = sprintf('%c%c', NAo_Diameter, NAo_Diameter);
fprintf(serial_port, data); %sends string via serial

pause(.5); % Arduino needs some time until data is processed!


%Setup Aperture Offset X
x_offset = -12;
x_centre+x_offset/2
fprintf(serial_port,'X'); %sends command for x_centre (image)
data = sprintf('%c%c', x_centre+x_offset/2, x_centre+x_offset/2);
fprintf(serial_port, data); %sends string via serial
 
pause(.5)

%Setup Aperture Offset Y
y_offset = -48;
y_centre+y_offset/2
fprintf(serial_port,'Y'); %sends command for y_centre (image)
data = sprintf('%c%c',  round(y_centre+y_offset/2), round(y_centre+y_offset/2));
fprintf(serial_port, data); %sends string via serial
 
pause(.5)



% %send image data over serial port
fprintf(serial_port,'S'); %sends string via serial
disp('Start')


% Close connection and reset
% fclose(serial_port); 
% delete(serial_port);

