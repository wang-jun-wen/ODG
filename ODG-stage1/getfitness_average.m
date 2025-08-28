function mean_mae = getfitness_average(hyperpara_set, data_group)
    mae_set = zeros(data_group, 1);
    warning('off', 'MATLAB:nearlySingularMatrix');
    parfor i = 1:data_group
        data_path = sprintf('C:\\Users\\wangjunwen\\Desktop\\Lorenz_train&validate_data%d.mat', i);
        data = load(data_path, 'Mtraining', 'Mvalidation');  
       
        Mtraining = data.Mtraining;
        Mvalidation = data.Mvalidation;

        indata = [Mtraining; Mvalidation];   
        outdata = [Mtraining; Mvalidation];  

        rng(i, 'twister');
        mae = getfitness(indata, outdata, hyperpara_set);
        mae_set(i) = mae;
    end
    mean_mae= mean(mae_set);
    fprintf('\nMean RMSE is %f\n', mean_rmse);
end

