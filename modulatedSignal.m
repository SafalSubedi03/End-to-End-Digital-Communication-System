function AM = modulatedSignal(Ac, m_t, c_t)
    % Generates AM modulated signal
    AM = (Ac + m_t) .* c_t;  %.* is used for element wise multiplication
    
end
