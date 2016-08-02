% Matlab + Arduino Serial Port communication
% Sending Zernike Polynomials to Arduino

close all;
clear all;
clc;

x_width = 240;
y_width = 320;

x_centre = (x_width/4);
y_centre = (y_width/4);

NA_Diameter = 30; % Pixeldiameter of Entire Condenser aperture


delay_time = 50; % time per Aperture divided by 10;
ApertureDiameter = 7; % Pixeldiameter of single aperture

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






%Setup Delay Time
fprintf(serial_port,'T'); %sends command for delay time (divided by 10)
data = sprintf('%c%c', delay_time, delay_time);
fprintf(serial_port, data); %sends string via serial
 
pause(.05)



%Setup Aperture Diameter
fprintf(serial_port,'A'); %sends command for x_width (image)
data = sprintf('%c%c', ApertureDiameter, ApertureDiameter);
fprintf(serial_port, data); %sends string via serial
pause(.05)



%Setup Aperture Offset X
x_offset = -12;
x_centre+x_offset/2
fprintf(serial_port,'X'); %sends command for x_centre (image)
data = sprintf('%c%c', x_centre+x_offset/2, x_centre+x_offset/2);
fprintf(serial_port, data); %sends string via serial


%Setup Aperture Offset Y
y_offset = -48;
y_centre+y_offset/2
fprintf(serial_port,'Y'); %sends command for y_centre (image)
data = sprintf('%c%c',  round(y_centre+y_offset/2), round(y_centre+y_offset/2));
fprintf(serial_port, data); %sends string via serial
 
pause(.05)

%Setup NA_Diameter
fprintf(serial_port,'N'); %sends command for NA_Diameter
data = sprintf('%c%c', NA_Diameter, NA_Diameter);
fprintf(serial_port, data); %sends string via serial

pause(.05)


%send image data over serial port
fprintf(serial_port,'I'); %sends string via serial
disp('Start')

% Close connection and reset
% fclose(serial_port); 
% delete(serial_port);

