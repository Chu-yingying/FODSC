function [U, C, Z, params] = initialize_parameters(F, K, m, alpha_dynamic, threshold)
    [B, d] = size(F);
    [Z,~] = InitializeSIGs(F');  
    rng(42);
    idx = kmeans(F, K);
    C = zeros(K, d);
    for j = 1:K
        C(j,:) = mean(F(idx==j, :), 1);
    end
    temp = 0.5;
    dist2C = pdist2(F, C, 'euclidean');
    U = exp(-dist2C.^2 / (2*temp^2));
    U = U ./ (sum(U,2) + 1e-12);

    params.n = d;
    params.B = B;
    params.K = K;
    params.m = m;
    params.alpha_dynamic = alpha_dynamic;
    params.threshold = threshold;
end