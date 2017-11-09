function sim_consts = set_sim_consts()
global sim_consts;
sim_consts = struct(...                          % SIMULATION OPTIONS
    'CP_puncture_pattern',zeros(120,1), ...      % CP_puncture_pattern
    'StTr_len',138, ...                          % symbol len 符号长度
    'frame_sym_num',7*20,  ...                    % symbols in one subframe
    'Cnum',24,...                                % cell number
    'ISD',sqrt(3)*250,...                        % distance between beams(min)
    'Freq',2.0e10,...                            % frequency 20GHz
    'Modulation', 'QPSK', ...                    % modulation schemes
    'Traffic_request',200*rand(1,24),...% cell traffic request 24个波束的业务需求设置为随机的一数组
    'bandwidthM2',125,...               % 模式2波束带宽125MHz
    'bandwidthM1',375,...               % 模式1波束带宽375MHz Ka频段四色复用的理想波束带宽
    'EOC',47,...                        % Edge of Coverage(EOC) Antenna Directivity Level 波束覆盖边界的增益47dB 5dB波束
    'EIRP_downlink',52)                 % peak EIRP of downlink 77.8dB\52dB 载波功率为100W 5m\2.8m天线的参数
    