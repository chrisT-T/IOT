% 用户输入参数
fs = input('请输入采样率（Hz）：');
frequency = input('请输入频率（Hz）：');
initial_phase = input('请输入初始相位（弧度）：');
duration = input('请输入信号持续时间（秒）：');

% 生成时间向量
t = 0:1/fs:duration;

% 生成声波信号
signal = sin(2 * pi * frequency * t + initial_phase);

% 保存声波信号为WAV文件
filename = 'generated_audio.wav'; % 指定文件名
audiowrite(filename, signal, fs);

disp(['声波信号已保存为 ', filename]);

% 播放声波信号
sound(signal, fs);

% 信号绘制
plot(t, signal);
xlabel('时间（秒）');
ylabel('信号幅度');
title('生成的声波信号');

