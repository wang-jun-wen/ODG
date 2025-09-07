% Rössler 系统参数
a = 0.2;
b = 0.2;
c = 5.7;
dt = 0.1;
num_points = 30000;

% 初始点列表
initial_points = [
           0.13810645, -0.26417572, 1.21724914
           -0.46720892, 0.73890137, -0.34258423
           0.03421192, -1.03354501, 0.02143068
           0.25198125, -0.07428967, 0.50363591
          -0.91275484, 0.05856277, -0.54092309
];

% 目标目录
output_dir = 'C:\Users\wangjunwen\Desktop\ESN_优化超参数-Rosser\data_make\Mtraining+Mtest';

% Rössler 系统动力学方程
rossler_system = @(state) [-state(2) - state(3); 
                           state(1) + a * state(2); 
                           b + state(3) * (state(1) - c)];

% 四阶龙格-库塔方法
for i = 1:size(initial_points, 1)
    data = zeros(num_points, 3);
    state = initial_points(i, :);
    
    % 生成数据
    for j = 1:num_points
        data(j, :) = state;
        k1 = rossler_system(state);
        k2 = rossler_system(state + 0.5 * dt * k1');
        k3 = rossler_system(state + 0.5 * dt * k2');
        k4 = rossler_system(state + dt * k3');
        state = state + (dt / 6) * (k1' + 2 * k2' + 2 * k3' + k4');
    end
    
    % 分割数据为 Mtraining 和 Mvalidation
    Mtraining = data(1:10200, :);
    Mtest = data(10201:end, :);
    
    % 生成文件名并保存数据到指定目录
    filename = fullfile(output_dir, sprintf('Rosser_train&test_data%d.mat', i));
    save(filename, 'Mtraining', 'Mtest');
end

disp('数据生成并保存到指定目录完成。');
