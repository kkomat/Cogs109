%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: /home/atomic/git/COGS109_Final/scripts/Wealth_Accounting.xlsx
%    Worksheet: Data
%
% To extend the code for use with different selected data or a different
% spreadsheet, generate a function instead of a script.

% Auto-generated by MATLAB on 2016/11/25 18:42:40

clear;
% Auto-generated by MATLAB on 2016/11/25 18:43:34

%% Import the data
[~, ~, raw] = xlsread('Wealth_Accounting.xlsx','Data');
raw = raw(2:end,5:end);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};


[~, ~, WealthAccounting] = xlsread('Wealth_Accounting.xlsx','Data');
WealthAccounting = WealthAccounting(2:end,1:3);
WealthAccounting(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),WealthAccounting)) = {''};

CountryName = WealthAccounting(:,1);
CountryCode = WealthAccounting(:,2);
IndicatorName = WealthAccounting(:,3);


% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

% Create output variable
data = reshape([raw{:}],size(raw));


%% Clear temporary variables
% clearvars data raw R;

% For energy depletion rate: 1006 is world
% Interval is by 31

% Incomes
start = 1044 - 1; % natural resource depletion (high)
start2 = 345 - 1; % net income current US (high)
start3 = 702 - 1; % natural resource depletion (medium)
start4 = 686 - 1; % net income current US (medium)
start5 = 578 - 1; % natural resource depletion (low)
start6 = 562 - 1; % net income current US(low)

step = 31;
year = [1970:2014];

%% Loops 

n = 50;
hold;
figure(1);
for i = 0:n
    plot(year, data(start+(i*step),:),'o-');
end
xlabel('Year');
ylabel(IndicatorName{start});
legend(CountryName{start :start + n*step:  step});
hold off;
% plot(year, data(1006-31,:));

    %% Selection Differences
hold;

plot3(year, data(start,:), data(start2,:), 'bo-');
plot3(year, data(start3,:), data(start4,:), 'go:');
plot3(year, data(start5,:), data(start6,:), 'ro--');

%plot(year, data(start2,:),'x:');
%plot(year, data(start,:) - data(start2,:),'o:');
%plot(year, data(start3,:),'+:');

xlabel('Year');
ylabel(IndicatorName{start});
zlabel(IndicatorName{start2});

grid on;
legend(CountryName{start},CountryName{start3}, CountryName{start5});
hold off;
lsline;


%% 
figure(3);
hold;
plot(year, data(start,:),'x:');
plot(year, data(start + step,:),'x:');
xlabel('Year');
ylabel(IndicatorName{start});
hold off;
lsline;
lsline;