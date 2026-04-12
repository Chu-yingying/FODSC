# Supplementary materials of FODSC 

We sincerely thank the two reviewers for their thorough evaluation of our manuscript and for providing constructive and insightful comments. We are also deeply grateful for the reviewers' positive assessment of the novelty of this work, as well as their recognition of the potential and value of the proposed hyperspectral band selection method, FODSC. Below are our specific responses to the reviewers' concerns regarding FODSC.

## **Response to Reviewer 1**

**1.It is recommended to present a complete objective function in Section 2, clearly showing how $\lambda_1$ , $\lambda_2$ , $\lambda_3$ work together.**

By integrating  the sample consistency constraint, band soft-assignment constraint, and the subspace clustering-based band selection module, the overall objective function is formulated as follows:

$$
\min_{\boldsymbol{Z}} \lVert \boldsymbol{F} - \boldsymbol{FZ} \rVert_F^2 + \lambda_1 \lVert \boldsymbol{Z} \rVert_* + \lambda_2 Tr\left( \boldsymbol{Z}^\top \boldsymbol{F}^\top \boldsymbol{L}^S \boldsymbol{FZ} \right) + \lambda_3 \lVert \boldsymbol{Z} \odot (1 - \boldsymbol{M}) \rVert_F^2
\quad s.t. \ z_{ij} \geq 0, \ diag(\boldsymbol{Z}) = \boldsymbol{0}
$$

where $\lambda_1$ , $\lambda_2$ and $\lambda_3$ are balancing coefficients. The first term is the reconstruction error, which ensures that $\mathbf{Z}$ preserves much information from  $\mathbf{F}$ as possible. The second term enforces the low-rank property of $\mathbf{Z}$. The third term encourages $\mathbf{Z}$ to capture the structural relationships induced by the underlying distribution of ground objects. The fourth term imposes a directional constraint on $\mathbf{Z}$ through an appropriate subspace partition, enabling a more accurate representation of the reconstruction relationships among spectral bands.

**2.Lack of statistical significance analysis: no statistical significance tests (e.g., t test or Friedman test) are provided to verify whether the differences between FODSC and other methods are statistically significant.**

To further verify the effectiveness and superiority of the proposed FODSC method, we conduct the Wilcoxon signed-rank test (with the significance level set to $\alpha$ = 0.05) on three hyperspectral datasets, namely IP220, HH270 and SA224. The results are presented in Table 1. The symbols in the table are defined as follows: “+” indicates that FODSC is significantly superior to the comparison method; “≈” indicates that there is no statistically significant difference between FODSC and the comparison method; “−” indicates that FODSC performs worse and “/” is the self- comparison.

<center><p>Table 1: The Wilcoxon signed-rank test for different BS methods</p></center>

<table style="font-size: 0.6em;">
    <tr>
        <th><center>Method</center></th>
        <th><center>IP220</center></th>
        <th><center>HH270</center></th>
        <th><center>SA224</center></th>
    </tr>
    <tr>
        <td class="method-header">OCF</td>
        <td><center>+</center></td>
        <td><center>+</center></td>
        <td><center>+</center></td>
    </tr>
    <tr>
        <td class="method-header">ASPS-MN</td>
        <td><center>+</center></td>
        <td><center>+</center></td>
        <td><center>+</center></td>
    </tr>
    <tr>
        <td class="method-header">RMGF</td>
        <td><center>+</center></td>
        <td><center>+</center></td>
        <td><center>≈</center></td>
    </tr>
    <tr>
        <td class="method-header">GAMR</td>
        <td><center>+</center></td>
        <td><center>≈</center></td>
        <td><center>+</center></td>
    </tr>
    <tr>
        <td class="method-header">S⁴P</td>
        <td><center>≈</center></td>
        <td><center>+</center></td>
        <td><center>+</center></td>
    </tr>
    <tr>
        <td class="method-header">SPCA-AMGL</td>
        <td><center>+</center></td>
        <td><center>+</center></td>
        <td><center>+</center></td>
    </tr>
    <tr>
        <td class="method-header">DVS³C</td>
        <td><center>+</center></td>
        <td><center>+</center></td>
        <td><center>+</center></td>
    </tr>
    <tr>
        <td class="method-header">FODSC</td>
        <td><center>/</center></td>
        <td><center>/</center></td>
        <td><center>/</center></td>
    </tr>
</table>

Among the 21 valid pairwise comparisons, FODSC achieves 18 “+” and 3 “≈”, with no “−” on all datasets. This indicates that, compared with most comparison methods, FODSC demonstrates consistently superior and statistically significant performance. Only in a few cases does FODSC perform comparably to certain state-of-the-art methods, showing no significant difference. Notably, there are no “−” results on any dataset, meaning that FODSC is never significantly inferior to the competing methods in any scenario. Overall, the Wilcoxon signed-rank test provides strong statistical support for the effectiveness and superiority of FODSC.

**3.Insufficient parameter sensitivity analysis: Although the optimal parameter combinations are given, the impact of key parameters (e.g., S , $\lambda_1$ , $\lambda_2$ , $\lambda_3$ ) on the results is not analyzed. A parameter sensitivity study is recommended.**

Taking the IP220 dataset as an example, we further conduct a sensitivity analysis of the segmentation scale S and the three regularization parameters $\lambda_1$ , $\lambda_2$ and $\lambda_3$ in FODSC. The relevant results are shown in Fig 1 and Table 2, respectively. It is worth noting that a univariate analysis strategy is adopted, where each parameter is varied individually while the others are fixed at their default values.

Firstly, Fig 1 illustrates the impact of parameters $\lambda_1$ , $\lambda_2$ and $\lambda_3$ on model performance under different numbers of bands. The results show that smaller values of $\lambda_1$ generally lead to higher accuracy. This is because a larger $\lambda_1$ will strengthen the low-rank constraint, which may disrupt the expression structure of the coefficient matrix. When $\lambda_1$ is set to 0.01 or 0.001, the model achieves better performance while maintaining stability. In addition, when $\lambda_2$ and $\lambda_3$ are set to 1, the model consistently attains relatively high accuracy across different band numbers. We speculate that this is mainly because the model assigns greater importance to the sample consistency constraint and the band soft-assignment constraint, enabling the coefficient matrix to simultaneously capture richer sample and spectral structural information, thereby obtaining a more discriminative band subset and further improving the model performance.

<img src="https://gitee.com/gui-yuan/images/raw/master/imgs/map.png" alt="替代文本" title="图片标题" width=1200>

<center><p>Fig 1: Sensitivity test of hyperparameters $\lambda_1$ , $\lambda_2$ and $\lambda_3$ in terms of AOA by SVM on IP220. (a) $\lambda_1$. (b) $\lambda_2$. (c) $\lambda_3$.</p></center>

Secondly, Table 2 reports the model accuracy under two superpixel scales, S=10 and S=100.  As observed, FODSC achieves slightly better overall performance when S=100 compared to S=10. This may be attributed to the fact that a larger spatial scale enables a more refined partitioning of homogeneous regions, thereby better capturing global spatial structure information. Meanwhile, it can also mitigate the influence of local noise and outliers to some extent, leading to a more reasonable modeling of spatial correlations among samples.

<center><p>Table 2: AOA values for different S on the IP220 dataset</p></center>

<table style="font-size: 0.6em;">
    <tr>
        <th><center>$S$</center></th>
        <th><center>5</center></th>
        <th><center>10</center></th>
        <th><center>15</center></th>
        <th><center>20</center></th>
        <th><center>25</center></th>
        <th><center>30</center></th>
        <th><center>35</center></th>
        <th><center>40</center></th>
    </tr>
    <tr>
        <td class="method-header">10</td>
        <td><center>0.6429</center></td>
        <td><center>0.7129</center></td>
        <td><center>0.7656</center></td>
        <td><center>0.7549</center></td>
        <td><center>0.7664</center></td>
        <td><center>0.6880</center></td>
        <td><center>0.6764</center></td>
        <td><center>0.7342</center></td>
    </tr>
    <tr>
        <td class="method-header">100</td>
        <td><center>0.7253</center></td>
        <td><center>0.7918</center></td>
        <td><center>0.8050</center></td>
        <td><center>0.8121</center></td>
        <td><center>0.8026</center></td>
        <td><center>0.8010</center></td>
        <td><center>0.7995</center></td>
        <td><center>0.7925</center></td>
    </tr>
</table>

**4.No code and data accessibility statement: it is advisable to include a statement in the abstract or conclusion about whether code and data links are provided for reproducibility.**

Thank the reviewer for the suggestion. We have supplemented the code and data availability statement to ensure the reproducibility and verifiability of the results. The relevant link (https://github.com/Chu-yingying/FODSC) has been attached at the end of the abstract and will be officially made public after the paper is accepted.

**5.Unify symbols and formula notations, and improve overall readability.**

Thank the reviewer for the comment. We have unified the symbols and formula notations in the revised manuscript, and optimized the formula cohesion and textual structure to improve the overall standardization and readability of the paper.

## **Response to Reviewer 2**

**1.This is a straightforward extension to the band selection problem in hyperspectral imaging applications, particularly in region segmentation and classification. The idea makes sense: using spatial content to identify homogeneous regions and then within each region perform region-specific soft band selection. Experimental results are enough and pretty convincing for a conference level publication. I expect the improvement to be more substantial(since the idea is fundamentally sound). This along with the extra computational complexity should be explored further if the authors would like to extend it to a journal version.**

We thank the reviewer for his/her positive feedback on our work. Although this paper has not yet been extended into a journal version, we have carefully considered the valuable suggestions provided. A brief analysis of the computational complexity of the proposed FODSC is provided as follows:

For a hyperspectral image $\boldsymbol{X}$, let the total number of pixels be $N$, and the number of bands be $B$. First, the ERS algorithm is adopted to segment the image into $S$ non-overlapping superpixels, with a computational complexity of $\mathcal{O}(B^2 N + B^3)$. On this basis, $n=DS(n \ll N)$ sample latent features are extracted for each superpixel, resulting in a time cost of $\mathcal{O}(B^2 N)$. During the iterative optimization phase, the update of the coefficient matrix $\boldsymbol{Z}$ involves matrix multiplication and SVD decomposition, which has a complexity of $\mathcal{O}(B^3)$; The adaptive update of the membership matrix $\boldsymbol{U}$ and the cluster center $\boldsymbol{C}$ has a complexity of $\mathcal{O}(KBn)$, where $K$ is the number of subspace. Since $K$ is relatively small, the total complexity after $T$ iterations is $\mathcal{O}(T B^3)$. Finally, in the band selection stage, the spectral clustering has a complexity of $\mathcal{O}(B^3)$, and selecting the bands based on the maximum entropy criterion from the clustering results has a complexity of $\mathcal{O}(BN+B\log B)$. In summary, the overall computational complexity of the proposed method is $\mathcal{O}(T B^3+B^2 N)$.

## **The ending**

We sincerely appreciate the reviewers' positive assessment of the novelty of this work and their recognition of the potential and practical value of the proposed FODSC within the overall research framework and methodological motivation. We fully understand and value the main concerns raised by the reviewers, and have provided comprehensive responses regarding the statistical significance tests of experiments, the parameter sensitivity analysis, as well as the time complexity and computational efficiency. We hope that this supplementary material addresses the reviewers' concerns. Once again, we thank the reviewers for their valuable suggestions, which have helped us identify key areas for improvement in the manuscript. We believe that incorporating this feedback will significantly enhance the quality and clarity of the paper.
