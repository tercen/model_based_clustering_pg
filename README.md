# GMM operator

##### Description

Model-based clustering based on finite Gaussian Mixture Models.

##### Usage

Input projection|.
---|---
`x-axis`        | numeric, input data, per cell
`cols`        | observations
`rows`        | variables

Input parameters|.
---|---
`n_clusters`        | Number of components of the mixture model (clusters). If 0 (default), the optimal number of clusters between 1 and 9 will be estimated.

Output relations|.
---|---
`cluster`        | cluster

##### Details

Number of clusters is automatically determined using the Bayesian Information Criterion. The operator is based on the mclust R package.

##### See Also

[kmeans_operator](https://github.com/tercen/kmeans_operator)