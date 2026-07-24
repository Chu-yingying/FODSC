function [] =Z_main(nc)
    name_dataset = 'IP220';
    Dataset = get_data(1);
    F = getF(Dataset, nc, 5);
    [Z_final, ~] =Z_knn_F_DPS(F, 5, 0.01, 1, 1, 0.6,0.6);  
    % ==== 聚类 + 波段选择 ====
    BandK = 5:5:40;
    for iBand = 1:length(BandK)
        kk= BandK(iBand);
        C= clu_ncut(Z_final, kk);
        Y=SelectBandFromClusResE(C,kk,Dataset.X)
        cube(iBand, 1:kk) = Y;
    end
end
