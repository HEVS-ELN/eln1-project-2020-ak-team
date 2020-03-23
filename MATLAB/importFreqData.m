path = 'C:\Users\alexxx\Desktop\Work\ELN1_Project2020\SoilDataSpiralProbe\';

for k=0:4
file = [path 'R10k_' num2str(k) '.csv'];
data = readmatrix(file);

freq(:,k+1) = data(:,1);
V2(:,k+1) = 10.^(data(:,3)/20).*exp(1j*data(:,4)*pi/180);
V1(:,k+1) = 10.^(data(:,2)/20);
end