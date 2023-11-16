% 读取音频文件
filename = 'res.wav';
[x, fs] = audioread(filename);

% 对信号进行离散傅里叶变换
X = fft(x);

% 计算频率轴
N = length(x); % 信号长度
frequencies = (0:N-1)*(fs/N);

% 绘制频谱图
figure;
plot(frequencies, abs(X));
title('频谱图');
xlabel('频率 (Hz)');
ylabel('幅度');
grid on;
