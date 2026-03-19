function [kp_att, ki_att, kd_att, kp_yw, ki_yw, kd_yw] = adjust_flight_pid(configuration)
    switch (configuration)
        case 1
            kp_att    = 128.505;
            ki_att   = 5.9203;
            kd_att    = 78.2000*2;

            kp_yw         = 25.7010*4*2;
            ki_yw         = 5.9203*0.01;
            kd_yw         = 78.2000*0.01;            
        case 2
            kp_att    = 128.505;
            ki_att   = 5.9203;
            kd_att    = 78.2000*2;

            kp_yw         = 25.7010*4*2;
            ki_yw         = 5.9203*0.01;
            kd_yw         = 78.2000*0.01;
        case 3
            kp_att    = 128.505;
            ki_att   = 5.9203;
            kd_att    = 78.2000*2;

            kp_yw         = 25.7010*4*2;
            ki_yw         = 5.9203*0.01;
            kd_yw         = 78.2000*0.01;
        case 4
            kp_att    = 128.505;
            ki_att   = 5.9203;
            kd_att    = 78.2000*2;

            kp_yw         = 25.7010*4*2;
            ki_yw         = 5.9203*0.01;
            kd_yw         = 78.2000*0.01;
    end
end
