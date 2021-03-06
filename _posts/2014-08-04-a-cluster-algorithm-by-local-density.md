---
layout: post
title: A Cluster Algorithm by Local Density
---
##Introduction##
The approach bases on the idea that cluster centers are characterized by a higher density than their neighbors and by a relatively large distance from points with higher density. Clusters with an arbitrary shape are easily detected by approaches on local density of data points.

{:toc}

###Assumption###
Cluster centers are surrounded by neighbors with lower local density and that they are at a relative large distance from any points with a higher local density.

###Process [^1]###
For each data point $$i$$, we compute two quantities: its local density $$\rho_{i}$$ and its distance $$\delta_{i}$$ from points of higher density. Both these quantities depend on the distance $$d_{ij}$$ between data points, which are assumed to satisfy the triangular inequality. 

The local density $$\rho_{i}$$ is defined as

$$
\begin{equation}
	\rho_{i}=\sum_{j}\chi(d_{ij}-d_{c})
\end{equation}
$$

where

$$
\begin{equation}
\chi(x) = 
    \begin{cases}
        1 & x<0 \\
        0 & \text{otherwise}
    \end{cases}
	\label{aa}
\end{equation}
$$

and $$ d_{c} $$ is a cutoff distance. Basically, $$ \rho_{i} $$  is equal to the number of points that are closer than $$ d_{c} $$  to point $$  i $$ . The algorithm is sensitive only to the relative maginitude of $$  \rho_{i} $$ in different points, implying that, for large data sets, the results of the analysis are robust with respect to the choice of $$  d_{c} $$.

$$ \delta_{i} $$  is measured by computing the minimum distance between the point $$ i $$  and other points with higher density than point $$ i $$:

$$
\begin{equation}
    \delta_{i} = \min_{j:\rho_{j}>\rho_{i}}(d_{ij})
\end{equation}
$$

For the point with highest density $\ref{aa}$, we conventionally take 

$$
\begin{equation}
	\delta_{i}=\max_{j}(d_{ij})
\end{equation}
$$

After the cluster centers have been found, each remaining point is assigned to the same cluster as its nearest neighbor of higher density.



[^1]: Exactly the same in the Alex Rodriguez and Alessandro Laio's paper [_Clustering by fast search and find of density peaks_](http://www.sciencemag.org/content/344/6191/1492.abstract).
