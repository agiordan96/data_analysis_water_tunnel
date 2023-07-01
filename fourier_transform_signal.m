function [] = fourier_transform_signal(signal, direction)
% Computes the Fourier transorm of a given signal

    switch direction
        case 1
            vector = signal.("Fx");
            vector = vector .* (-1);
        case 2
            vector = signal.("Fy");
        case 3
            vector = signal.("Fz");
    end

    transformed = fft(vector);

    figure 

    title('Original signal')
    plot(1:length(vector), vector)
    xlabel('time [s]')
    ylabel('force [N]')

    figure 

    title('Transformed signal')
    plot(1:length(transformed), transformed)
    xlabel('freq [Hz]')
%     ylabel('force [N]')

end