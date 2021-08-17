%This program converts from raw counts to number concentration given the
%APS is running at std flows 5 LPM total with 1LPM aersol Flow
%Output is in #/cc
%sampleTime is in seconds

function concentration = rawToConcentration(counts, sampleTime)
    aerosolFlow = 83.3333333333333/5; % 5LPM/5 or 1 LPM in cc/s
    concentration = counts./(aerosolFlow.*sampleTime);

end