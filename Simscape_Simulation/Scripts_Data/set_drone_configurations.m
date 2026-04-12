%% Angles of Arms
% Format = [1 2 3 4] in degress
armPresets = [
    0    0    0    0;   % X shape (default)
    120  120  120  120; % O shape
    45  -45  -45   45;  % H shape
    45  -45   45  -45;  % T shape
   -120 -120 -120 -120; % O* shape
   -45   45   45  -45;  % H* shape
   -45   45  -45   45   % T* shape
];

% Imported from Simulink
configs;
hold_time;
transistion_time;
transforms;

for n = 1:length(configs)
    if (configs(:, n) < 1) || (configs(:,n) > size(armPresets, 1))
        configs(:,n) = 1;
    end
end

% Ensures transistion time is at least 0.2s shorter than hold time
if hold_time <= transistion_time
    transistion_time = hold_time - 0.2;
end

num_of_transforms = length(configs);

%% --- Enhanced X-Shape Injection with Pass-Through Timing ---
if (transforms)
    % 1. Inject X-shapes and track 'Pass-Through' status
    original_configs = configs;
    new_configs = original_configs(1);
    is_passthrough = false; % First shape is never a pass-through
    
    for i = 2:length(original_configs)
        if original_configs(i) ~= 1 && original_configs(i-1) ~= 1
            % Inject X-shape and mark it as a pass-through
            new_configs = [new_configs, 1, original_configs(i)];
            is_passthrough = [is_passthrough, true, false];
        else
            new_configs = [new_configs, original_configs(i)];
            is_passthrough = [is_passthrough, false];
        end
    end
    configs = new_configs;
    num_of_transforms = length(configs);
    
    % 2. Initialize Arrays
    sections = (2 * num_of_transforms) - 1;
    angles = zeros([sections 4]);
    mix_history = zeros(4, 4, sections); 
    timespots = zeros([1 sections]);
    
    % 3. Timing and Angle Loop
    time = 0;
    for form = 1:sections
        timespots(form) = time;
        
        % Calculate timing increments
        if form == 1
            time_inc = hold_time - (transistion_time / 2);
        elseif mod(form, 2) == 1 % --- HOLD PERIODS ---
            current_shape_idx = ceil(form / 2);
            if is_passthrough(current_shape_idx)
                % If it's an injected X, set hold time to nearly zero
                % This makes the transition continuous
                time_inc = 0.001; 
            else
                time_inc = hold_time - transistion_time;
            end
        else % --- TRANSITION PERIODS ---
            time_inc = transistion_time;
        end
        
        % 4. Assign Mixer and Angles (Same as before)
        config_idx = configs(ceil(form / 2));
        [~,~,~,~,~,~, current_mixer] = adjust_flight_pid(config_idx);
        mix_history(:,:,form) = current_mixer;
        
        for arm = 1:4
            angles(form, arm) = armPresets(config_idx, arm);
        end
        
        time = time + time_inc;
    end
else
    % Static case
    angles = zeros([1 4]);
    timespots = 0;
    for x = 1:4
        angles(:, x) = armPresets(configs(:, 1), x);
    end
    [~,~,~,~,~,~, mix_history] = adjust_flight_pid(configs(:, 1));
end

%% --- Final Timeseries Generation ---
mixer_ts = timeseries(mix_history, timespots);
mixer_ts.DataInfo.Interpolation = 'linear'; % Critical for smooth morphing
% Ensure the timeseries objects are properly configured
arm4.DataInfo.Interpolation = 'linear';
arm3.DataInfo.Interpolation = 'linear';
arm2.DataInfo.Interpolation = 'linear';
arm1.DataInfo.Interpolation = 'linear';

%% Create Timeseries Objects
arm4 = timeseries(angles(:, 4), timespots);
arm3 = timeseries(angles(:, 3), timespots);
arm2 = timeseries(angles(:, 2), timespots);
arm1 = timeseries(angles(:, 1), timespots);

% Create the Mixer timeseries (Simulink's From Workspace block will read this)
mixer_ts = timeseries(mix_history, timespots);
