function [FM_Signal] = FMGenerator( t, Ac, fc,m_t,kf)
%FMGENERATOR 
% 
N = length(t);
a = zeros(1,N);
dt = t(2) - t(1);
for i = 1 : N
    sum = 0;
    for j = 1 : i
        sum = sum + m_t(j) * dt;
    end
    a(i) = sum;
end

FM_Signal = Ac * cos(2*pi*fc *t + kf * a);
end

