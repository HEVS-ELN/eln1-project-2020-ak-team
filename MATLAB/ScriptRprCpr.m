% Import data
path = 'C:\Users\Alexa\eln1-project-2020-ak-team\data\ConductiveProbe\';
freq = [];
V1=[];
V2=[];
for k=0:4
file = [path 'R10k_' num2str(k) '.csv'];
data = readmatrix(file, 'Range', 2);

% Declare variables
freq(:,k+1) = data(:,1);
V2(:,k+1) = 10.^(data(:,3)/20).*exp(1j*data(:,4)*pi/180);
Amp2(:,k+1) = 10.^(data(:,3)/20);
Phase2(:,k+1) = data(:,4)*pi/180;
R1 = 10000;
Rscope = 1e6;
Cscope = 24e-12;

end

% Compute Rprobe
Rpr = ((Amp2*R1).*sqrt(1+tan(Phase2).^2))./(1-Amp2.*sqrt(1+tan(Phase2).^2));
RealRpr = 1./((1./Rpr)-(1/Rscope));

% Compute Cprobe
Cpr = -((R1+Rpr).*tan(Phase2))./(2*pi.*freq.*(Rpr*R1));
RealCpr = Cpr - Cscope;

% Plot boths on the same window
subplot(2,1,1); % (first plot)

% Plot Rpr
loglog(freq, RealRpr);

subplot(2,1,2); % (Second plot)

% Plot Cpr
loglog(freq, RealCpr);