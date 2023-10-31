function hw1_2(filename)
    % 检查输入参数
    if nargin < 1
        error('请提供音频文件的文件名');
    end

    % 读取音频文件
    [audioData, sampleRate] = audioread(filename);

    % 计算音频时长（秒）
    audioDuration = length(audioData) / sampleRate;

    % 创建时间向量
    time = (0:1/sampleRate:audioDuration-1/sampleRate);

    % 绘制波形图
    figure;
    plot(time, audioData);
    title('音频波形图');
    xlabel('时间（秒）');
    ylabel('幅度');

    % 显示音频文件信息
    fprintf('音频文件信息:\n');
    fprintf('文件名: %s\n', filename);
    fprintf('采样率: %d Hz\n', sampleRate);
    fprintf('时长: %.2f 秒\n', audioDuration);
end
