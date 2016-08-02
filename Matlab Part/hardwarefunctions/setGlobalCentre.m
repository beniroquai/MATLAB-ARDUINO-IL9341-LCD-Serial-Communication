function setGlobalCentre( serial_port, xc ,yc )
% setGlobalCentre()
% This function sets the global coordinates for displayinng
% the aperture right in the centre of the microscopes pupil
% 
% xc - coordinate decentered in x-direction; absolute x_width = 240px
% yc - coordinate decentered in y-direction; absolute y_width = 320px
%
% example: setGlobalCentre( 120, 120); Sets the centre to position 120, 120


pause(.05)

%Setup Aperture Offset X
fprintf(serial_port,'a'); %sends command for xi
fprintf(serial_port,'%d', xc);
pause(0.05)


%Setup Aperture Offset Y
fprintf(serial_port,'b'); %sends command for xi
fprintf(serial_port,'%d', yc);
pause(0.05)


%Show centre coordinates
fprintf(serial_port,'C'); %sends command for xi
pause(0.05)


end




