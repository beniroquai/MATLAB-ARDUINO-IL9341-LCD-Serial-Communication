function setGrayscale( serial_port, grayvalue)
% setGrayscale()
% This functions set the grayvalue of the entire LCD
% 
% grayvalue - the 8Bit grayscale value to get the Gamma-curve
% 0..255
%
% example: setGrayscale( 'COM7', 20); 


%Setup inner annulus
fprintf(serial_port,'i'); %sends command for xi
fprintf(serial_port,'%d', di);
pause(0.05)

%Setup Aperture Offset Y
fprintf(serial_port,'o'); %sends command for yi 
fprintf(serial_port,'%d', do);
pause(0.05)

% Execute scanned aperture

fprintf(serial_port,'P'); %sends command for dAperture (image)



end




