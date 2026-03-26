function [kp_att, ki_att, kd_att, kp_yw, ki_yw, kd_yw, mixer_matrix] = adjust_flight_pid(configuration)
    % Default Matrix (Standard X/H/T shapes)
    standard_mixer = [ 1 -1 -1  1; ... % w1
                      -1 -1  1  1; ... % w2
                       1  1  1  1; ... % w3
                      -1  1 -1  1];    % w4
    
    switch (configuration)
        case 1 % X Shape
           kp_att    = 128.505;
            ki_att   = 5.9203;
            kd_att    = 78.2000*2;

            kp_yw         = 25.7010*4*2;
            ki_yw         = 5.9203*0.01;
            kd_yw         = 78.2000*0.01;
            mixer_matrix = standard_mixer;
        case 2 % O Shape
            kp_att = 250;     
            kd_att = 300;
            kp_yw  = 400;     
            kp_att    = 128.505;
            ki_att   = 5.9203;
            kd_att    = 78.2000*2;

            kp_yw         = 25.7010*4*2;
            ki_yw         = 5.9203*0.01;
            kd_yw         = 78.2000*0.01;
            % O-shape matrix: Reduced Pitch/Roll authority, Zero Yaw for stability
            mixer_matrix = [ 0.06 -0.04  1  1; ...
                            -0.06 -0.04  1  1; ...
                             0.06  0.04  1  1; ...
                            -0.06  0.04  1  1];
        case 3 % H Shape
            kp_att    = 128.505;
            ki_att   = 5.9203;
            kd_att    = 78.2000*2;

            kp_yw         = 25.7010*4*2;
            ki_yw         = 5.9203*0.01;
            kd_yw         = 78.2000*0.01;
            mixer_matrix = standard_mixer;
        case 4 % T Shape
            kp_att    = 128.505;
            ki_att   = 5.9203;
            kd_att    = 78.2000*2;

            kp_yw         = 25.7010*4*2;
            ki_yw         = 5.9203*0.01;
            kd_yw         = 78.2000*0.01;
            mixer_matrix = standard_mixer;
        otherwise % Default
            kp_att    = 128.505;
            ki_att   = 5.9203;
            kd_att    = 78.2000*2;

            kp_yw         = 25.7010*4*2;
            ki_yw         = 5.9203*0.01;
            kd_yw         = 78.2000*0.01;
            mixer_matrix = standard_mixer;
    end
end