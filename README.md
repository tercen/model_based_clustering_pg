# Model-based clustering operator

##### Description

Model-based clustering based on finite Gaussian Mixture Models.

##### Usage

Input projection|.
---|---
`x-axis`      | character, x-axis value (e.g. Sample Name)
`y-axis`      | numeric, y-axis value

Input parameters|.
---|---
`Number of clusters`  | Number of components of the mixture model (clusters). If auto (default), the optimal number of clusters between 1 and 9 will be estimated.

Output relations|.
---|---
`clusterIdx`        | cluster id

##### Details

Number of clusters is automatically determined using the Bayesian Information Criterion. The operator is based on the mclust R package.

##### See Also

[gmm_operator](https://github.com/tercen/gmm_operator)
[kmeans_operator](https://github.com/tercen/kmeans_operator)
