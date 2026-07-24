function mask = generate_Z_mask(U, K)
    B = size(U,1);
    mask = zeros(B,B);
    [~, main_cluster] = max(U, [], 2);
    for i = 1:B
        for j = 1:B
            if main_cluster(i) == main_cluster(j)
                mask(i,j) = 1;
            else
                u_i = U(i,:);
                u_j = U(j,:);
                cos_sim = dot(u_i, u_j) / (norm(u_i)*norm(u_j));
                mask(i,j) = (cos_sim + 1)/2 ;  % 保留动态加权
            end
        end
    end
    mask = mask - diag(diag(mask));
end