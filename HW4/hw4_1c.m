% 读取音频文件
filename = 'res.wav';
[x, fs] = audioread(filename);

% 不同窗口长度的设置
window_lengths = [16, 32, 64, 128, 256, 512];

% 创建一个figure
figure;

for i = 1:length(window_lengths)
    % 使用spectrogram进行短时傅里叶变换
    subplot(length(window_lengths), 1, i);
    spectrogram(x, hann(window_lengths(i)), window_lengths(i)/2, window_lengths(i), fs, 'yaxis');
    title(['窗口长度 = ' num2str(window_lengths(i))]);
end

% 添加共同的横坐标标签
xlabel('时间 (秒)');

% 调整subplot的间距
sgtitle('不同窗口长度下的时频图');
