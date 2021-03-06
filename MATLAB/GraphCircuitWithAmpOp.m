path = 'C:\Users\Alexa\eln1-project-2020-ak-team\data\';
freq = [];
V1=[];
V2=[];

file = [path 'RprCprAmpOpWithVin.txt'];
data = readmatrix(file, 'Range', 2);

% Declare variables
sampleFreq = 50000;
nSamples = 64;
Vmax = 0.6;
SignalFreq = 2000;
time = data(:,1);
Vout = data(:,2);
Vin = data(:,3);

% Import LT Spice value

%lastLine = 2982;
%stepInds = [0;find(isnan(data(:,1)));lastLine];
%for k=1:(size(stepInds,1)-1)
%    dta = data(stepInds(k)+1:stepInds(k+1)-1,:);
%    t0 = dta(1,1);
%    nSamples = 500;
%    tstep = (dta(end,1)-dta(1,1))/nSamples;
%    t1 = (t0:(tstep):dta(end,1))';
%
%    V1(:,k) = interp1(dta(:,1), dta(:,2), t1);
%    V2(:,k+1) = interp1(dta(:,1), dta(:,3), t1);
%    plot(V1);
%end

lastLine = 2982;
stepInds = [0;find(isnan(data(:,1)));lastLine];
for k=1:(size(stepInds,1)-1)
    dta = data(stepInds(k)+1:stepInds(k+1)-1,:);
    t0 = data(1,1)+rand(1)/SignalFreq;
    t1 = (t0:2/(sampleFreq):t0+(nSamples-1)*2/(sampleFreq))';
    t2 = t1+1/sampleFreq;
    V1(:,k) = interp1(dta(:,1), dta(:,2), t1);
    V2(:,k) = interp1(dta(:,1), dta(:,3), t2);
    NoiseBits = 7;    %what are noise bits? Related to effective bits of the ADC

    %What do these lines do?? What is randn() ?
    V1dig=int16((2^15)*(V1/Vmax)+randn(nSamples,1)*(2^NoiseBits));
    V2dig=int16((2^15)*(V2/Vmax)+randn(nSamples,1)*(2^NoiseBits));

    %What do these lines do??
    V1d=double(V1dig)*Vmax/(2^15);
    V2d=double(V2dig)*Vmax/(2^15);
    plot(V2);
end
polyfit([1 ratio],[0 0 1 2 3 4],3);
ratio = mean(abs(V1d))./mean(abs(V2d));
IndHum = 4.13-1.5*ratio-10.52*ratio.^2+7.91*ratio.^3