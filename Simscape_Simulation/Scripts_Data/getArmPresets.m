function armPresets = getArmPresets()
armPresets = [
%Arm1    2    3    4
    0    0    0    0;  % X shape (default)
    90   90   90   90; % O shape
    45  -45  -45   45; % H shape
    45  -45   45  -45; % T shape
    60   30  -30  -60  % test shape
];
end