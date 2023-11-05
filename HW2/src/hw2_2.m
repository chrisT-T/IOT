%BPSK
Code_array = [0,1,0,0,1,1,1,0,1,1,0,0,1,0,1,0]; % 输入的二进制串
Modulator(Code_array, 'bpsk', 10)
Demodulator('bpsk')

%% 信号调制
function Modulator(Code_array, fileName, SNR) 
    Sample_frequency = 48e3; % 采样频率
    Symbol_duration = 0.025; % 调制符号持续时间
    Base_frequency = 20e3; % 调制信号频率

    % Generate base signal
    N = Sample_frequency * Symbol_duration; % 调制符号的采样点数
    t = (0:N-1) / Sample_frequency; % 每一采样点对应的时刻
    Base_signal = sin(2 * pi * Base_frequency * t);

    % Generate modulated symbols
    Modulated_signal = zeros(1, N * length(Code_array));
    for i = 1:length(Code_array)
        pa = 1 - 2 * Code_array(i); % 根据Code判断是否相位翻转
        Modulated_signal((i - 1) * N + (1 : N)) = pa * Base_signal; % 逐码字生成调制信号
    end
    %figure(1)
    %plot(Modulated_signal)
    %title('调制后信号')

    % 向调制信号加入高斯白噪声
    Noise_signal = awgn(Modulated_signal, SNR, 'measured');
    Noise_signal = Noise_signal / max(abs(Noise_signal));
 
    %figure(2)
    %plot(Noise_signal)
    %title('加噪声后信号')

    audiowrite([fileName, '.wav'], Noise_signal, Sample_frequency)

    disp(['声波信号已保存为 ', fileName]);
end

%% 信号解调
function Demodulator(fileName) 
    % Read signal from a WAV file
    [sig, sample_frequency] = audioread([fileName, '.wav']);
    sig = sig';
    Symbol_duration = 0.025; % 调制符号持续时间
    Base_frequency = 20e3; % 调制信号频率

    N = sample_frequency * Symbol_duration; % 采样点数
    num_symb = floor(length(sig) / N); % 调制符号数
    
    t = (0:N-1) / sample_frequency; % 采样时刻
    Base_signal = sin(2 * pi * Base_frequency * t); % 基信号
    Base_signal = repmat(Base_signal, 1, num_symb); % 基信号延拓

    y = sig(1:N*num_symb) .* Base_signal; % 与基信号相乘
    

    y = lowpass(y,100,sample_frequency); % 低通滤波

    plot(y);
    title('信号振幅(低通滤波后) ')

    result = [];
    for i = 1 : num_symb % 符号分割
        symb = y((i-1) * N + 1 : i * N);
        tmp = sum(symb) < 0; % 能量聚集
        result = [result, tmp];
    end

    disp(['ans: ' num2str(result)]);
    disp(['len：' num2str(length(result))]);
end
