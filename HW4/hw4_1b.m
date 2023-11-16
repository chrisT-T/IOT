% 读取音频文件
filename = 'res.wav';
[x, fs] = audioread(filename);

% 补零，使信号长度延展为原序列的 10 倍
x_padded = [x; zeros((length(x) * 9), 1)];

% 对未补零的信号进行离散傅里叶变换
X = fft(x);

% 对补零后的信号进行离散傅里叶变换
X_padded = fft(x_padded);

% 计算频率轴
N = length(x); % 未补零信号长度
frequencies = (0:N-1)*(fs/N);

N_padded = length(x_padded); % 补零后信号长度
frequencies_padded = (0:N_padded-1)*(fs/N_padded);

% 创建一个figure
figure;

% 绘制未补零信号的频谱图
subplot(2, 1, 1);
plot(frequencies, abs(X));
title('未补零的频谱图');
xlabel('频率 (Hz)');
ylabel('幅度');
grid on;

% 绘制补零后信号的频谱图
subplot(2, 1, 2);
plot(frequencies_padded, abs(X_padded));
title('补零后的频谱图');
xlabel('频率 (Hz)');
ylabel('幅度');
grid on;
