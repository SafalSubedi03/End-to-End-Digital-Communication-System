function m = generateMessage(t, Am, fm)
    % Generate a message signal 
    m = Am * cos(2*pi*fm.*t);
end
