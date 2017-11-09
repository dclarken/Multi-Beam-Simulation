function sim_consts = set_sim_consts()
global sim_consts;
sim_consts = struct(...                          % SIMULATION OPTIONS
    'CP_puncture_pattern',zeros(120,1), ...      % CP_puncture_pattern
    'StTr_len',138, ...                          % symbol len ���ų���
    'frame_sym_num',7*20,  ...                    % symbols in one subframe
    'Cnum',24,...                                % cell number
    'ISD',sqrt(3)*250,...                        % distance between beams(min)
    'Freq',2.0e10,...                            % frequency 20GHz
    'Modulation', 'QPSK', ...                    % modulation schemes
    'Traffic_request',200*rand(1,24),...% cell traffic request 24��������ҵ����������Ϊ�����һ����
    'bandwidthM2',125,...               % ģʽ2��������125MHz
    'bandwidthM1',375,...               % ģʽ1��������375MHz KaƵ����ɫ���õ����벨������
    'EOC',47,...                        % Edge of Coverage(EOC) Antenna Directivity Level �������Ǳ߽������47dB 5dB����
    'EIRP_downlink',52)                 % peak EIRP of downlink 77.8dB\52dB �ز�����Ϊ100W 5m\2.8m���ߵĲ���
    