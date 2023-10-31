% 设置采样频率和录音时长
fs = input('请输入采样率（Hz）：');
recordTime = input('请输入信号持续时间（秒）：');

% 创建音频录制对象
recObj = audiorecorder(fs, 16, 1); % 16位深度，单声道

% 开始录音
disp('开始录音...');
recordblocking(recObj, recordTime); % 阻塞录音指定时长

% 结束录音
disp('录音结束');

% 获取录音数据
audioData = getaudiodata(recObj);

% 保存录音为WAV文件
wavFileName = 'recorded_audio.wav';
audiowrite(wavFileName, audioData, fs);

disp(['声波信号已保存为 ', wavFileName]);

% 清理录音对象
delete(recObj);
