% Import data
path = 'C:\Users\Alexa\eln1-project-2020-ak-team\data\';
freq = [];
V1=[];
V2=[];

file = [path 'VoutRprCpr.txt'];
data = readmatrix(file, 'Range', 3);

% Declare variables
time = data(:,1);
Vout = data(:,2);

% Import LT Spice value

lastLine = 209;
stepInds = [0;find(isnan(data(:,1)));lastLine];
for k=1:(size(stepInds,1)-1)
    dta = data(stepInds(k)+1:stepInds(k+1)-1,:);
    t0 = dta(1,1);
    nSamples = 500;
    tstep = (dta(end,1)-dta(1,1))/nSamples;
    t1 = (t0:(tstep):dta(end,1))';

    V1(:,k) = interp1(dta(:,1), dta(:,2), t1);
end