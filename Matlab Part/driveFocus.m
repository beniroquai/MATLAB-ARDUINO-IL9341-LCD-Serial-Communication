function driveFocus( serial_port, speed, time)
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
fprintf(serial_port,'v'); %sends command for xi
fprintf(serial_port,'%d', abs(time));
pause(0.05)

fprintf(serial_port,'m'); %sends command for xi
fprintf(serial_port,'%d', abs(speed));
pause(0.05)

if time > 0
    fprintf(serial_port,'U'); %sends command for xi
    pause(0.05)
else
    fprintf(serial_port,'D'); %sends command for xi
    pause(0.05)
end

pause(abs(time)/1000);


end




