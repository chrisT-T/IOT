# README

平台：MATLAB

1. 脉冲间隔信号的调制与解调
	- `hw2_1.m` 运行

```
>> hw2_1
声波信号已保存为 modulatedAudio1
ans: 0  0  1  0  0  1  1  1  0  1  1  0  0  1  0  1  0
len：17
```



2. BPSK信号的调制与解调 
	- `hw2_2.m` 运行

```
>> hw2_2
声波信号已保存为 bpsk
ans: 0  1  0  0  1  1  1  0  1  1  0  0  1  0  1  0
len：16
```



3. 验证调制、解调算法在噪声环境下的性能
	- 修改SNR `Modulator(Code_array, fileName, SNR) `，第三个参数为SNR的值
	- 修改调制符号长度 `Symbol_duration = 0.025; % 调制符号持续时间`