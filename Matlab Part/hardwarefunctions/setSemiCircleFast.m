function setSemiCircleFast( serial_port, radius_o, radius_i, angle)
% setGlobalCentre()
% This function sets the global coordinates for displayinng
% the aperture right in the centre of the microscopes pupil
% 
% radius_o - outer radius of semi circle
% radius_i - inner radius of semi circle
% angle - rotation angle of semi circle
% example: setPhaseContrast( 'COM7', 20); 


%Setup radius
fprintf(serial_port,'e'); %sends command for r
fprintf(serial_port,'%d', radius_o);
pause(.05)

%Setup radius
fprintf(serial_port,'k'); %sends command for r
fprintf(serial_port,'%d', radius_i);
pause(.05)

%Setup angle
fprintf(serial_port,'f'); %sends command for yi 
fprintf(serial_port,'%d', angle);
pause(0.05)

% Execute semi circle

fprintf(serial_port,'h'); %sends command for dAperture (image)


end




