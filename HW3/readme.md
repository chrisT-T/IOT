# README

平台：MATLAB

1. QPSK信号的调制与解调

	- `hw3_1.m`运行

	```
	>> hw3_1
	声波信号已保存为modulatedAudio
	ans: 0  1  0  0  1  1  1  0  1  1  0  0  1  0  1  0
	len：16
	```

2. 验证调制、解调算法在噪声环境下的性能

	- 修改SNR `Modulator(Code_array, fileName, SNR) `，第三个参数为SNR的值
	- 修改调制符号长度 `T = 0.025; % 调制符号持续时间`

3. 长度为N的序列的N点DFT

	a) `hw3_1_a.m` 运行

	b) `hw3_1_b.m` 运行

	c) `hw3_1_b.m` 运行