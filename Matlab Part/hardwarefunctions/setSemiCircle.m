function setSemiCircle( serial_port, radius, angle)
% setGlobalCentre()
% This function sets the global coordinates for displayinng
% the aperture right in the centre of the microscopes pupil
% 
% radius - radius of semi circle
% angle - rotation angle of semi circle
% example: setPhaseContrast( 'COM7', 20); 


%Setup radius
fprintf(serial_port,'e'); %sends command for r
fprintf(serial_port,'%d', radius);
pause(.05)

%Setup angle
fprintf(serial_port,'f'); %sends command for yi 
fprintf(serial_port,'%d', angle);
pause(0.05)

% Execute semi circle

fprintf(serial_port,'g'); %sends command for dAperture (image)


end




