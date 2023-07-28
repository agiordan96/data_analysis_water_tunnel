function [] = fourier(y, direction, wingtype)

  switch direction
        case 1
            vector = y.("Fx");
            vector = vector .* (-1);
        case 2
            vector = y.("Fy");
        case 3
            vector = y.("Fz");
    end

    t = linspace(0, 30, 1200);
    L = length(t);
    Fs = L/(t(end)-t(1));
    %n = 2^nextpow2(L);
    n = 1024; %pow2(nextpow2(L));
    Y = fft(vector,n);
    
    %f = Fs*(0:(n/2))/n;
    f = (0:n-1)*(Fs/n);
    P = abs(Y).^2/n;
    
    figure

    plot(f(2:end), P(2:end))
    title(strcat('data ', wingtype, ' wing'))
    xlabel('Frequency (f)')
    ylabel('|P(f)|')
    xlim([0 20])

%     save_plot(gcf, "fourier", direction, aoa, speed / 100, png)
end