function setPhaseContrast( serial_port, di , do)
% setGlobalCentre()
% This function sets the global coordinates for displayinng
% the aperture right in the centre of the microscopes pupil
% 
% do - outer diameter of annullus
% di - outer diameter of annullus
% 
% example: setPhaseContrast( 'COM7', 10 , 20); 


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




