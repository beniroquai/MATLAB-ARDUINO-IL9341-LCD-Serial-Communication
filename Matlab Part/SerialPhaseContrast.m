% Matlab + Arduino Serial Port communication
% Sending Zernike Polynomials to Arduino

close all;
clear all;
clc;

x_width = 240;
y_width = 320;

x_centre = (x_width/4);
y_centre = (y_width/4);

x_offset = 0;
y_offset = -30;

NAi_Diameter = 22; % Pixeldiameter of inner Condenser aperture
NAo_Diameter = 100; % Pixeldiameter of outer Condenser aperture


% NAi_Diameter = 0; % Pixeldiameter of inner Condenser aperture
% NAo_Diameter = 2; % Pixeldiameter of outer Condenser aperture
% 

%Declaration of Serial Port
delete(instrfind({'Port'},{'COM7'}));
serial_port=serial('COM7');
serial_port.BaudRate=250000;
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');

%Open Serial Port
fopen(serial_port); 


%Wait until Arduino is ready for communication
result = 0;
while(result~=-1.0)
    result=fscanf(serial_port,'%d')  
end

pause(.05)


%Setup NA_Diameter
fprintf(serial_port,'I'); %sends command for NAi_Diameter
data = sprintf('%c%c', NAi_Diameter, NAi_Diameter);
fprintf(serial_port, data); %sends string via serial

pause(0.05); % Arduino needs some time until data is processed!


%Setup NAo_Diameter
%NAo_Diameter = 16; % Pixeldiameter of outer Condenser aperture
fprintf(serial_port,'O'); %sends command for NAi_Diameter
data = sprintf('%c%c', NAo_Diameter, NAo_Diameter);
fprintf(serial_port, data); %sends string via serial

pause(.05); % Arduino needs some time until data is processed!


%Setup Aperture Offset X
x_offset = -12;
x_centre+x_offset/2
fprintf(serial_port,'X'); %sends command for x_centre (image)
data = sprintf('%c%c', x_centre+x_offset/2, x_centre+x_offset/2);
fprintf(serial_port, data); %sends string via serial
 
pause(.05)

%Setup Aperture Offset Y
y_offset = -48;
y_centre+y_offset/2
fprintf(serial_port,'Y'); %sends command for y_centre (image)
data = sprintf('%c%c',  round(y_centre+y_offset/2), round(y_centre+y_offset/2));
fprintf(serial_port, data); %sends string via serial
 
pause(.05)



% %send image data over serial port
fprintf(serial_port,'S'); %sends string via serial
disp('Start')


% Close connection and reset
% fclose(serial_port); 
% delete(serial_port);

