% 脉冲间隔调制
Code_array = [0,1,0,0,1,1,1,0,1,1,0,0,1,0,1]; % 输入的二进制串
Modulator(Code_array, 'modulatedAudio1', 20)
Demodulator('modulatedAudio1')

%% 信号调制
function Modulator(Code_array, fileName, SNR) 
    % 信号参数
    Fs = 48e3; % 采样频率 48kHz
    T = 0.01; % 脉冲持续时间 10ms
    f = 20e3; % 脉冲信号频率 20kHz
    A = 1; 
    t = 0:1/Fs:T;
    
    % 基础信号
    pulse = A*cos(2*pi*f*t); % 脉冲信号
    interval = zeros(1,Fs*T); % 间隔 10ms
    bit_0 = [pulse, interval]; % 20ms
    bit_1 = [pulse, interval, interval]; % 30ms

    signal = [];
    for i = (1:length(Code_array))
        if Code_array(i) == 1
            signal = [signal,bit_1];
        else
            signal = [signal,bit_0];
        end
    end
    
    signal = [signal,pulse];
    
    %figure(1)
    %plot(signal);
    %title('脉冲间隔调制信号')

    % 向调制信号加入高斯白噪声
    Noise_signal = awgn(signal, SNR, 'measured');

    %figure(2)
    %plot(Noise_signal);
    %title('脉冲间隔调制信号（高斯白噪音 SNR=10db）')
    
    audiowrite([fileName, '.wav'], Noise_signal, Fs)

    disp(['声波信号已保存为 ', fileName]);
end

%% 信号解调
function Demodulator(fileName, cnt, SNR) 
    % 信号参数
    T = 0.01; % 脉冲持续时间 10ms
    A = 1; 

    % Read signal from a WAV file
    [signal, Fs] = audioread([fileName, '.wav']);
    signal = signal';
    
    threhold_Amp = A/2; % 幅度阈值
    threhold_Interval = Fs*T*(2+3)/2; % 脉冲间隔阈值

    signal = bandpass(signal,[20000, 21000],Fs); %带通滤波
    
    amp = abs(hilbert(signal)); % 提取信号振幅
    
    plot(amp);
    title('信号振幅 SNR=')
    
    result = [];
    start = 0;
    
    for i = (2:length(signal))
        % 寻找脉冲边界
        if amp(i) > threhold_Amp && amp(i-1) < threhold_Amp
            % 计算脉冲间隔
            if i - start > threhold_Interval
                result = [result, 1];
            else
                result = [result, 0];
            end
            start = i; % 更新脉冲边界
        end
    end
    
    disp(['ans: ' num2str(result)]);
    disp(['len：' num2str(length(result))])
end




