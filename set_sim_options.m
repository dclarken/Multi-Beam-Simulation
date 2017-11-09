function sim_options = set_sim_options();
sim_options = struct(...                % SIMULATION OPTIONS
    'cell_radius',250,...               % cell radius 250km
    'frame', 32,...                     % total frames for cell search procedure
    'Modulation', 'QPSK')               % modulation schemes