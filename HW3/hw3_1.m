Code_array = [0,1,0,0,1,1,1,0,1,1,0,0,1,0,1,0];

Modulator(Code_array, 'modulatedAudio', 0)

Demodulator('modulatedAudio')

function Modulator(codes, fileName, sigSNR)
    fs = 48000;
    T = 0.025; % 调制符号持续时间
    f = 1 / T;
    
    %若信号长度不是偶数，则补0（QPSK调制的是长度为偶数的二进制串）
    cLen = length(codes);
    if mod(cLen, 2) == 1
        codes = [codes, 0];
        cLen = cLen + 1;
    end
    
    %生成I信号和Q信号
    sigI = sin(2 * pi * f * (0 : 1/fs : T - 1/fs));
    sigQ = cos(2 * pi * f * (0 : 1/fs : T - 1/fs));
    
    %生成两路基带信号，并相加
    sigL = length(sigI);
    sig = zeros(1, sigL * cLen / 2);
    for i = 1 : cLen / 2
        fI = (1 - 2 * codes(i * 2 - 1)) * sqrt(2) / 2;
        fQ = (1 - 2 * codes(i * 2)) * sqrt(2) / 2;
        sig((i - 1) * sigL + 1 : i * sigL) = fI * sigI + fQ * sigQ;
    end
    
    subplot(2, 1, 1);
    plot(sig)
    title(['调制后信号 (SNR = ', num2str(0), ', T=50ms)'])
    
    %模拟信道，添加白噪声
    sig = awgn(sig, sigSNR, 'measured');
    %将信号幅度恢复为1
    sig = sig / max(abs(sig));
    
    audiowrite([fileName, '.wav'], sig, fs);

    disp(['声波信号已保存为', fileName]);

end

function Demodulator(fileName)
    [sig, fs] = audioread([fileName, '.wav']);
    sig = sig';
    T = 0.025;
    f = 1 / T;
    
    %生成I信号和Q信号
    sigI = sin(2 * pi * f * (0 : 1/fs : T - 1/fs));
    sigQ = cos(2 * pi * f * (0 : 1/fs : T - 1/fs));
    
    %生成星座图上的4个点对应的标准基带信号，保存在一个4行的矩阵中
    sigL = length(sigI);
    sigMat = sqrt(2) / 2 * (...
        [1; 1; -1; -1] .* repmat(sigI, 4, 1) + ...
        [1; -1; 1; -1] .* repmat(sigQ, 4, 1));
    
    cLen = 2 * length(sig) / sigL;
    codes = zeros(1, cLen);

    subplot(2, 1, 2);
    plot(sig);
    title('信号振幅 ')
    
    for i = 1 : cLen / 2
        seg = sig((i - 1) * sigL + 1 : i * sigL);
        %通过积分的方式（积分针对的是连续信号，离散信号则是对点积求和），判断当前的这一段信号和哪个标准信号距离最近。积分的结果越大代表两个信号越相似。
        [~, maxI] = max(sigMat * seg');
        codes(2 * i - 1) = maxI > 2;
        codes(2 * i) = mod(maxI, 2) == 0;
    end

    disp(['ans: ' num2str(codes)]);
    disp(['len：' num2str(length(codes))]);

end