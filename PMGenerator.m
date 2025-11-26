function Pm_signal = PMGenerator(t, m_t, kp ,Ac, fc )
    Pm_signal = Ac * cos(2*pi*fc .*t + kp .*m_t);
end

