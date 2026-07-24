function [U_opt, C_opt] = optimize_U_FCM_adaptive(F, U_prev, C_prev, params, m, alpha_dynamic, threshold)
    B = params.B;
    n = params.n;
    K = params.K;

    C_opt = zeros(K, n);
    for i = 1:K
        weights_prev = U_prev(:, i).^m; % 上一轮的U^m
        x_j = F; % 所有样本（B×n）
        c_i_prev = C_prev(i,:); 
        r_ij = sqrt(sum((x_j - repmat(c_i_prev, B, 1)).^2, 2)) + 1e-12;

        alpha_ij = alpha_dynamic * (-1).*(U_prev(:,i) >= threshold) + alpha_dynamic.*(U_prev(:,i) < threshold);

        weight_corrected = weights_prev .* (2*r_ij + alpha_ij) ./ r_ij;
        
        % 聚类中心更新
        numerator = sum(bsxfun(@times, weight_corrected, x_j), 1);
        denominator = sum(weight_corrected) + 1e-12;
        C_opt(i,:) = numerator / denominator;
    end

    d = zeros(B,K);
    for j=1:B
        x_j = F(j,:);
        for i=1:K
            c_i = C_opt(i,:);
            r = norm(x_j - c_i,2);
            r2 = r^2;
            if U_prev(j,i) < threshold
                alpha_ij = alpha_dynamic;
            else
                alpha_ij = -alpha_dynamic;
            end
            d(j,i) = max(r2 + alpha_ij*r, 0);
        end
    end

    exponent = 1/(m-1);
    U_new = zeros(B,K);
    for j=1:B
        for i=1:K
            denom_sum = 0;
            for l=1:K
                denom_sum = denom_sum + (d(j,i)/d(j,l))^exponent;
            end
            U_new(j,i) = 1/ (denom_sum + 1e-12);
        end
    end

    U_new = max(U_new,1e-12);
    U_opt = bsxfun(@rdivide, U_new, sum(U_new,2)+1e-12);
end