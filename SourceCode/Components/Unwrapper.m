[file,path] = uigetfile('*.csv');
Directory = strcat(path,file);
UnitPhase = csvread(Directory);
[width,length]= size(UnitPhase);
ProcessedPhase = UnitPhase(:,2:length);
for i = 1:1:length-1
    flag = 0; % 0 = negative, 1 = positive
    preflag = 0;
    unwrapflag = 0;
    for j=1:1:width
        if ProcessedPhase(j,i) < 0
            flag = 0;
        elseif ProcessedPhase(j,i) > 0
            flag = 1;
        end
        if preflag == 0 && flag == 1
            unwrapflag = unwrapflag + 1;
        end
        if unwrapflag > 0
            ProcessedPhase(j,i) = ProcessedPhase(j,i) - unwrapflag*360;
        end
        preflag = flag;
    end
end
ProcessedPhase = ProcessedPhase(:,:) - ProcessedPhase(1,:);
ProcessedReport = cat(2,UnitPhase(:,1),ProcessedPhase);

[~,Numplot] = size(ProcessedReport);
for i=2:1:Numplot
    plot(ProcessedReport(:,1),ProcessedReport(:,i));
    hold on;
end
xlabel("Dimension (R1) / mm");
ylabel("Phase Shift (degree)");
%title("Element Phase Shift");
thetacount = 0;
counter = 1;
for i=2:1:Numplot
    legendstr{counter} = sprintf('theta = %d',thetacount);
    thetacount = thetacount + 10;
    counter = counter + 1;
end

legend(legendstr)

% legend('K2 = 0.75','K2 = 0.1','K2 = 0.125');
% colorbar('hide');
axis('tight');
% hold off;


