function [img3D,map]=read_data(name_dataset)


switch name_dataset

    case "IP220"
        img3D = load("Indian_pines.mat").indian_pines;
        map = load("Indian_pines_gt.mat").indian_pines_gt;

    case "PU103"
        img3D = load("PaviaU.mat").paviaU;
        map = load("PaviaU_gt.mat").paviaU_gt;

    case "HO144"
        mat_file = load("Houston_2013.mat");
        img3D = mat_file.Houston_img;
        map = mat_file.Houston_gt;

    case "SA224"
        img3D = load("Salinas.mat").salinas;
        map = load("Salinas_gt.mat").salinas_gt;

    case "DC191"
        mat_file = load("DC_Sub.mat");
        img3D = mat_file.DC_Sub;
        map = mat_file.grd;

    case "KS176"
        img3D = load("KSC.mat").KSC;
        map = load("KSC_gt.mat").KSC_gt;

    case "G5150"
        img3D = load("gf5.mat").gf5;
        map = load("gf5_gt.mat").gf5_gt;

    case "HH270"
        img3D = load("HongHu.mat").HongHu;
        map = load("HongHu_gt.mat").HongHu_gt;

    case "PA176"
        img3D =load("QUH-Pingan_Sub.mat").Haigang_sub;
        map = load("QUH-Pingan_Sub_GT.mat").HaigangGT_sub;

    case "QY176"
        img3D =load("Qingyu_Sub.mat").Qingyu_sub;
        map = load("Qingyu_Sub_GT.mat").Qingyu_sub_GT;

    case "QY176A"
        img3D =load("Qingyu_Sub_A.mat").Qingyu_sub_A;
        map = load("Qingyu_Sub_GT_A.mat").Qingyu_sub_GT_A;

    case "QY176B"
        img3D =load("Qingyu_Sub_B.mat").Qingyu_sub_B;
        map = load("Qingyu_Sub_GT_B.mat").Qingyu_sub_GT_B;
end

img3D = img3D./max(img3D(:));
end