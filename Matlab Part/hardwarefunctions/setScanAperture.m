function setScanAperture( serial_port, xi , yi, dAperture, exposureTime )
% setGlobalCentre()
% This function sets the global coordinates for displayinng
% the aperture right in the centre of the microscopes pupil
% 
% xi - absolute Coordinate of scanned aperture in X-direction [0..0139]
% yi - absolute Coordinate of scanned aperture in Y-direction [0..319]
% dAperture - diameter of scanned aperture in pixel
% time - delay time of scanned aperture when it is diplayed in ms
%
% example: setScanAperture( 'COM7', 120, 120, 5, 100); Sets the centre to
% position 120, 120; Diameter: 5; timedelay 100ms


%Setup Aperture Offset X
fprintf(serial_port,'x'); %sends command for xi
fprintf(serial_port,'%d', xi);
pause(0.01)

%Setup Aperture Offset Y
fprintf(serial_port,'y'); %sends command for yi 
fprintf(serial_port,'%d', yi);
pause(0.01)



% Setup diameter of scanned aperture
fprintf(serial_port,'d'); %sends command for dAperture (image)
pause(0.01)
fprintf(serial_port,'%d', dAperture); 
pause(0.01)



% Setup delay time of scanned aperture
fprintf(serial_port,'t'); %sends command for delay time
pause(0.01)
fprintf(serial_port,'%d', exposureTime);
pause(0.01) 

% Execute scanned aperture

fprintf(serial_port,'S'); %sends command for dAperture (image)

pause(.8*exposureTime/1000)



end




