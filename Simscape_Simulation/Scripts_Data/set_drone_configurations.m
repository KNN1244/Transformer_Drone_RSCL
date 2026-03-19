%% Angles of Arms
% Format = [1 2 3 4] in degress
armPresets = [
    0    0    0    0;  % X shape (default)
    90   90   90   90; % O shape
    45  -45  -45   45; % H shape
    45  -45   45  -45; % T shape
    60   30  -30  -60  % test shape
];

% Imported from Simulink
configs;
hold_time;
transistion_time;
transforms;

% Ensures transistion time is at least 0.2s shorter than hold time
if hold_time <= transistion_time
    transistion_time = hold_time - 0.2;
end

num_of_transforms = length(configs);

% Initialize set angles
angles = [];

% Initialize position times
timespots = [];

if (transforms)
    % Minimum numer of time stamps to prevent early transformations
    sections = (2 * num_of_transforms) - 1;
    angles = zeros([sections 4]);
    timespots = zeros([1 sections]);
    
    time = 0;
    time_inc = 0;
    
    for form = 1:sections
        % Determines the proper time stamps for when transformations occur
        timespots(:, form) = time;
        if form == 1
            time_inc = hold_time - (transistion_time / 2);
        elseif mod(form, 2) == 1
            time_inc = hold_time - transistion_time;
        elseif mod(form, 2) == 0
            time_inc = transistion_time;
        end
        time = time + time_inc;
        
        % Determines what angle each arm is at each time
        for arm = 1:4
            shape = ceil(form / 2);
            angles(form, arm) = armPresets(configs(:,shape), arm);
        end
    end
else
    angles = zeros([1 4]);
    timespots = 0;

    for x = 1:4
        angles(:, x) = armPresets(configs(:, 1), x);
    end
end

% angles
% timespots

arm4 = timeseries(angles(:, 4), timespots);
arm3 = timeseries(angles(:, 3), timespots);
arm2 = timeseries(angles(:, 2), timespots);
arm1 = timeseries(angles(:, 1), timespots);