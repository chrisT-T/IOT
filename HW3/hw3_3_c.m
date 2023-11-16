N = [16, 64, 1024]; % 输入的N值

for i = 1:length(N)
    n = transpose(0:N(i)-1); % 构造序列的离散时间标签
    y = sin((2*pi*n)/N(i)); % 构造序列

    Y = fft(y, N(i)); % 计算N点DFT
    Y = [Y(N(i)/2+1:end); Y(1:N(i)/2)];

    % 补零的FFT
    r = 16;
    yn2 = fft(y, N(i)*r); % 计算N点DFT
    yn2 = [yn2(N(i)*r/2+1:end); yn2(1:N(i)*r/2)];

    % 绘制频谱图
    f = (0:N(i)-1)*(1/N(i)); % 构造频率轴
    f2 = (0:N(i)*r-1)*(1/(N(i)*r)); % 构造频率轴

    magnitude = abs(Y); % 计算幅度谱


    % 创建子图并绘制幅度谱
    subplot(length(N), 1, i);

    plot(f2, abs(yn2),'color','black','linewidth',1.5); hold on
    stem(f, magnitude,'color',[0,118,168]/255,'linewidth',1.5,'linestyle','none');
    
    title(['Frequency Spectrum (N = ', num2str(N(i)), ')']);
    xlabel('频率（Hz）');
    ylabel('强度');

    legend('补零', '不补零', 'Location', 'NorthEast');
end
