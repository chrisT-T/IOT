% 获取用户输入的两个序列
n = input('range: ' );
sequence1 = input('请输入第一个序列: ');
sequence2 = input('请输入第二个序列: ');

% 计算序列的长度
N = length(sequence1);

% 计算离散傅里叶变换
X1 = fft(sequence1);
X2 = fft(sequence2);

% 计算循环卷积
Y = ifft(X1 .* X2);

% 显示结果
disp('循环卷积结果:');
disp(Y);

% 绘制原始序列和循环卷积结果的图形
figure;
subplot(3, 1, 1);
stem(sequence1);
title('序列1');

subplot(3, 1, 2);
stem(sequence2);
title('序列2');

subplot(3, 1, 3);
stem(Y);
title('循环卷积结果');
