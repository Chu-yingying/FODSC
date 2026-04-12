# Supplementary materials of FODSC 

We sincerely thank the two reviewers for their thorough evaluation of our manuscript and for providing constructive and insightful comments. We are also deeply grateful for the reviewers' positive assessment of the novelty of this work, as well as their recognition of the potential and value of the proposed hyperspectral band selection method, FODSC. Below are our specific responses to the reviewers' concerns regarding FODSC.

## **Response to Reviewer 1**

1.It is recommended to present a complete objective function in Section 2, clearly showing how $\alpha$ , $\lambda_1$ , $\lambda_2$ work together.

**Incorporating the sample consistency constraint, band soft assignment constraint, and the subspace clustering-based band selection module, the overall objective function is given as follows:**

$$
\min_{\boldsymbol{Z}} \lVert \boldsymbol{F} - \boldsymbol{FZ} \rVert_F^2 + \lambda_1 \lVert \boldsymbol{Z} \rVert_* + \lambda_2 Tr\left( \boldsymbol{Z}^\top \boldsymbol{F}^\top \boldsymbol{L}^S \boldsymbol{FZ} \right) + \lambda_3 \lVert \boldsymbol{Z} \odot (1 - \boldsymbol{M}) \rVert_F^2
\quad s.t. \ z_{ij} \geq 0, \ diag(\boldsymbol{Z}) = \boldsymbol{0}
$$

**Among them, $\lambda_2$ , $\lambda_2$ and $\lambda_3$ are balance coefficients. The first term is a residual term, ensuring that $\mathbf{Z}$ retains the vast majority of information in $\mathbf{F}$ as much as possible. The second term constrains the low-rank property of $\mathbf{Z}$ . The third term makes  $\mathbf{Z}$  follow the structural relationship under the feature of ground object distribution. The fourth term, through reasonable subspace division, directionally constrains  $\mathbf{Z}$  to more accurately express the reconstruction relationship between bands.**

2.Lack of statistical significance analysis: no statistical significance tests (e.g., t test or Friedman test) are provided to verify whether the differences between FODSC and other methods are statistically significant.

**To further verify the effectiveness and superiority of the proposed FODSC method, we conduct the Wilcoxon signed-rank test (with the significance level set to $\alpha$ = 0.05) on three hyperspectral datasets, namely IP220, HH270 and SA224. The results are shown in Table 1. The meanings of the symbols in the table are as follows: “+” indicates that FODSC is significantly superior to the comparison method; “≈” indicates that there is no statistically significant difference between FODSC and the comparison method; “-” indicates that FODSC has worse performance and “/” is the self-control.**

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

**Among the 21 valid comparisons, FODSC achieves 18 “+” and 3 “≈”, with no “-” on all datasets. This indicates that compared with most comparison methods, FODSC exhibits a sustained and significant performance advantage. Only in a few scenarios, FODSC has comparable performance with some state-of-the-art methods, without significant differences. It is worth emphasizing that no “-” results appear on all datasets, that is, FODSC is not significantly inferior to the comparison methods in any scenario. Overall, the Wilcoxon signed-rank test provides strong statistical support for the effectiveness and superiority of FODSC.**

3.Insufficient parameter sensitivity analysis: Although the optimal parameter combinations are given, the impact of key parameters (e.g., S , $\lambda_1$ , $\lambda_2$ , $\lambda_3$ ) on the results is not analyzed. A parameter sensitivity study is recommended.

**Taking the Indian Pines dataset as an example, we supplement the sensitivity analysis of the segmentation scale S and the three regularization parameters $\lambda_1$ , $\lambda_2$ and $\lambda_3$ in FODSC, and the relevant results are shown in Fig 1 and Table 2, respectively. It should be noted that this paper adopts a univariate analysis strategy to verify the role of each parameter, and the remaining parameters are kept at their default values unchanged.**

**Firstly, Fig 1 shows the influence of parameters $\lambda_1$ , $\lambda_2$ and $\lambda_3$ on the model performance under different numbers of bands. The results indicate that the smaller the value of $\lambda_1$ , the higher the model accuracy. This is because a larger $\lambda_1$ will strengthen the effect of the low-rank constraint, which may damage the expression structure of the coefficient matrix. When $\lambda_1$ is set to 0.01 or 0.001, the model achieves superior performance while maintaining stability. In addition, when $\lambda_2$ and $\lambda_3$ are set to 1, the model can reach high accuracy under different numbers of bands. We speculate that this is mainly because the model assigns relatively higher weights to the sample consistency constraint and the band soft assignment constraint based on dynamic subspace division, enabling the coefficient matrix to simultaneously capture richer sample information and spectral structure information, thereby obtaining a more discriminative band subset and further improving the model performance.**

<img src="https://gitee.com/gui-yuan/images/raw/master/imgs/map.png" alt="替代文本" title="图片标题" width=1200>

<center><p>Fig 1: Sensitivity test of hyperparameters $\lambda_1$ , $\lambda_2$ and $\lambda_3$ in terms of AOA by SVM on IP220. (a) $\lambda_1$. (b) $\lambda_2$. (c) $\lambda_3$.</p></center>

**Secondly, Table 2 presents the model accuracy when the superpixel scale S=10 and S=100. As can be seen from the table, the overall performance of FODSC is slightly superior when S=100 compared to S=10. This may be because a larger spatial scale can divide homogeneous regions more finely to capture global spatial structure information, and weaken the interference of local noise and abnormal samples to a certain extent, thereby modeling the spatial correlation between samples more reasonably**

<center><p>Table 2: AOA values for different S on the Indian Pines dataset</p></center>

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

4.No code and data accessibility statement: it is advisable to include a statement in the abstract or conclusion about whether code and data links are provided for reproducibility.

**Thank the reviewers for their suggestions. We have supplemented the code and data availability statement to ensure the reproducibility and verifiability of the results. The relevant link (https://github.com/Chu-yingying/FODSC) has been attached at the end of the abstract and will be officially made public after the paper is accepted.**

5.Unify symbols and formula notations, and improve overall readability.

**We thank the reviewer for the suggestion. We have unified the symbols and formula notations in the revised manuscript, and optimized the formula cohesion and textual structure to improve the overall standardization and readability of the paper.**

## **Response to Reviewer 2**

1.This is a straightforward extension to the band selection problem in hyperspectral imaging applications, particularly in region segmentation and classification. The idea makes sense: using spatial content to identify homogeneous regions and then within each region perform region-specific soft band selection. Experimental results are enough and pretty convincing for a conference level publication. I expect the improvement to be more substantial(since the idea is fundamentally sound). This along with the extra computational complexity should be explored further if the authors would like to extend it to a journal version.

**...**

## **The ending**

**We sincerely appreciate the reviewers' positive assessment of the novelty of this work and their recognition of the potential and practical value of the proposed FODSC within the overall research framework and methodological motivation. We fully understand and value the main concerns raised by the reviewers, and have provided comprehensive responses regarding the statistical significance tests of experiments, the parameter sensitivity analysis, as well as the time complexity and computational efficiency. We hope that this supplementary material addresses the reviewers' concerns. Once again, we thank the reviewers for their valuable suggestions, which have helped us identify key areas for improvement in the manuscript. We believe that incorporating this feedback will significantly enhance the quality and clarity of the paper.**
