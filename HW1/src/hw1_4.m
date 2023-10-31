% 参数设置
fs = 48000;          % 采样频率为48kHz
f_signal = 20000;    % 信号频率为20kHz
A = 1;               % 振幅为1
symbol_duration = 0.025; % 每个符号调制长度为25ms

% 用户输入自定义的 input_signal
input_signal = input('请输入您的二进制信号 (例如：[0 1 0 0 1 1 1 0 0 1 0 0 1]):\n ');

% 生成OOK调制信号
modulated_signal = zeros(1, length(input_signal) * symbol_duration * fs);
t = 0:1/fs:symbol_duration-1/fs;
for i = 1:length(input_signal)
    if input_signal(i) == 1
        modulated_signal((i-1)*symbol_duration*fs+1:i*symbol_duration*fs) = A * sin(2*pi*f_signal*t);
    end
end

% 保存OOK调制信号为WAV文件
audiowrite('OOK_Modulated_Signal.wav', modulated_signal, fs);

% 读取OOK调制信号的音频文件
[received_signal, fs] = audioread('OOK_Modulated_Signal.wav');

% 参数设置
f_signal = 20000;    % 信号频率为20kHz
symbol_duration = 0.025; % 每个符号调制长度为25ms

% 解调OOK信号
symbol_length = round(fs * symbol_duration);
num_symbols = length(received_signal) / symbol_length;
decoded_symbols = zeros(1, num_symbols);

for i = 1:num_symbols
    % 提取当前符号的信号段
    symbol_segment = received_signal((i-1)*symbol_length+1:i*symbol_length);
    
    % 计算该符号段的平均幅度
    average_amplitude = mean(abs(symbol_segment));
    
    % 判决门限，根据幅度判定是0还是1
    if average_amplitude >= 0.5
        decoded_symbols(i) = 1;
    else
        decoded_symbols(i) = 0;
    end
end

% 输出解调后的二进制符号组合
disp(decoded_symbols);
