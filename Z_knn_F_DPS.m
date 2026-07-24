function [Z_final, U_final, C_final, obj] = Z_knn_F_DPS(F, K, alpha, lambda2, lambda_mask, alpha_dynamic,threshold)
    [B, n] = size(F);
    m = 1.8;              
    mu = 0.5;             
    max_mu = 50;
    mu_inc = 1.03;
    max_iter = 100;
    epsilon = 1e-4;                           
    % 预计算拉普拉斯
    Lh1 = get_Lap(F', 5);
    FFt = F * F';
    Xt= F * (Lh1+Lh1') * F';
    % 初始化
    [U_prev, C_prev, Z_prev, params] = initialize_parameters(F, K, m, alpha_dynamic, threshold);
    J_prev = Z_prev;              
    A_prev = zeros(B, B);         

    fprintf('开始交替迭代优化...\n');

    for iter = 2:max_iter
        mask = generate_Z_mask(U_prev, K);  % 生成掩码
        [Z_curr, J_curr, A_curr] = optimize_Z(FFt, mask, Z_prev, J_prev, A_prev, ...
            params, alpha, lambda_mask, mu, lambda2, Xt);
        [U_curr, C_curr] = optimize_U_FCM_adaptive(F, U_prev, C_prev, params , m, alpha_dynamic, threshold);
         
        term1 = norm(F' - F'*Z_curr,'fro')^2;
        [~,S,~] = svd(Z_curr);
        term2 = alpha*sum(diag(S));
        term3 = lambda_mask * norm(Z_curr.* (1 - mask), 'fro')^2;
        term4 = lambda2*trace((Z_curr')*F*Lh1*(F')*Z_curr);
        tmp= term1 + term2 + term3+ term4;
        obj(iter) = tmp;
        deltaU = mean(abs(U_curr(:) - U_prev(:)));
        deltaZ = mean(abs(Z_curr(:) - Z_prev(:)));

        if iter >= 2 &&( abs(obj(iter) - obj(iter-1)) / (abs(obj(iter-1))))<epsilon && deltaU<1e-4 && deltaZ<1e-4
            fprintf('迭代收敛！迭代次数: %d | obj=%.6f | 最终Z稀疏度=%.2f%%\n', ...
                iter, obj_curr, sum(Z_curr(:)<1e-6)/numel(Z_curr)*100);
            obj = obj(1:iter);
            break;
        end

        Z_prev = Z_curr;
        J_prev = J_curr;
        A_prev = A_curr;
        U_prev = U_curr;
        C_prev = C_curr;
        mu = min(max_mu, mu_inc*mu);
    end

    Z_final = Z_curr;
    U_final = U_curr;
    C_final = C_curr;
end

%% -------------------------- Z 更新 --------------------------
function [Z_curr, J_curr, A_curr] = optimize_Z(FFt, mask, Z_prev, J_prev, A_prev, params, alpha, lambda_mask, mu, lambda2, Xt)
    B = params.B;
    I = eye(B);
    max_inner_iter = 20; 
    tau = 1 / (2*norm(FFt) + lambda2*norm(Xt) + mu + 2*lambda_mask); 
    
    Z_temp = Z_prev;
    for inner = 1:max_inner_iter
        % 计算光滑项梯度
        grad_term1 = 2 * FFt * (Z_temp - I);
        grad_term3 = 2 * lambda_mask * (Z_temp .* (1 - mask).*(1-mask));
        grad_term5 = lambda2 *Xt * Z_temp;
        grad_admm = mu * (Z_temp - J_prev) + A_prev;
        grad_total = grad_term1 + grad_term3 + grad_term5 + grad_admm;
        
        Z_temp = Z_temp - tau * grad_total;
        Z_temp(Z_temp < 0) = 0; 
    end
    
    X_admm = Z_temp + A_prev / mu; 
    tau_svt = alpha / mu; % SVT阈值
    [U_svd, S_svd, V_svd] = svd(X_admm);
    S_thresh = max(S_svd - tau_svt * I, 0);
    J_curr = U_svd * S_thresh * V_svd'; 

    Z_curr = Z_temp; 
    % 对偶变量A更新
    A_curr = A_prev + mu * (Z_curr - J_curr);
    
    Z_curr = Z_curr - diag(diag(Z_curr));
    Z_curr(Z_curr < 0) = 0;
end

