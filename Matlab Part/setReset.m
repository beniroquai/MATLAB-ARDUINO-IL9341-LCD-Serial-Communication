function setReset(serial_port)
% setReset()
% This function blackens the screen
% 
% 

% Reset Screen

fprintf(serial_port,'R'); %sends command for dAperture (image)
fprintf(serial_port,'o'); %sends command for yi 

end




