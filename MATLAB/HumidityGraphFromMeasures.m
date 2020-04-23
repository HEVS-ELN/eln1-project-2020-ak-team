% Import data
path = 'C:\Users\Alexa\eln1-project-2020-ak-team\data\HumidityMeasures\';
freq = [];
V1=[];
V2=[];
dta=[];
for k=0:4
file = [path 'Humidity' num2str(k) '.csv'];
data = readmatrix(file, 'Range', 2);

lastLine = 8192;
% Import LT Spice value
    dta = data(1:lastLine,:);
    t0 = dta(1,1);
    nSamples = 500;
    tstep = (dta(end,1)-dta(1,1))/nSamples;
    t1 = (t0:(tstep):dta(end,1))';

    V1(:,k+1) = interp1(dta(:,1), dta(:,2), t1);
    V2(:,k+1) = interp1(dta(:,1), dta(:,3), t1);
end