% -- Save Result
if connect_flag == 0
    y      = Simulated_time_series.data(:,1)/4; % 名目金利以外の他系列は年率なので４で割る
    pi     = Simulated_time_series.data(:,2) + (2-terminal_rate);
    epi    = Simulated_time_series.data(:,4) + (2-terminal_rate);
    tau    = Simulated_time_series.data(:,5) + (2-terminal_rate);
    r_lb   = Simulated_time_series.data(:,7);
    data_export = [y pi epi tau r_lb];

elseif connect_flag == 1
    y      = Simulated_time_series.data(:,1)/4; % 名目金利以外の他系列は年率なので４で割る
    pi     = Simulated_time_series.data(:,2);
    epi    = Simulated_time_series.data(:,4);
    tau    = Simulated_time_series.data(:,5);
    r_lb   = Simulated_time_series.data(:,7);
    data_tmp = [y pi epi tau r_lb];
    data_export = data_tmp(2:end,:);
end