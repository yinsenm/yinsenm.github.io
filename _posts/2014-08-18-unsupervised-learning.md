---
layout: post
title: Unsupervised learning of the KDD99 dataset 
---

Visualize the a normalized 10K subset of [KDD99](http://kdd.ics.uci.edu/databases/kddcup99/kddcup99.html) via PCoA.

* Randomly subset 10K of $$\frac{1}{10}$$ of KDD as $$M_{1}$$. 
* Normalize dataset $$M_{1}$$ by row as $$M_{2}$$.
* Calculate pairwise distance matrix $$D$$ between columns in $$M_{2}$$.
* Use PCoA to decompose $$D$$ into $$Y$$ and select the top $$2$$ columns.
* Plot the dataset with original labels

{% highlight matlab %}
>> M2 = normr(M1);
>> D = pdist(M2,'euclidean'); 
>> [Y,eigvals] = cmdscale(D);
>> eigvals(1:6)
ans =

   1.0e+03 *

   1.978672284362840
   1.356004445388113
   0.275720798037440
   0.218854479696284
   0.155187763185168
   0.065183380944231
{% endhighlight %} 

Select the columns with the largest 2 eigen values and plot the 2D graph colored by the original labeling as shown below.

![kddraw](/assets/unsupervised/kddraw.png)

-----------------

After regularizing labels by [five types](http://cseweb.ucsd.edu/~elkan/tabulate.html) by the following criteria, again we plot the their labels.

Code|Type of attack
---|---
1|normal
2|probe
3|denial of service (DOS)
4|user-to-root (U2R)
5|remote-to-local (R2L)

{% highlight matlab %}
for i = 1:length(Y)
	ic=int8(((Lc(i)+1)*64.)/(5*1.));
	hold on;
	plot(Y(i,1), Y(i,2), 'o', 'MarkerSize', 5, 'MarkerFaceColor', cmap(ic,:), 'MarkerEdgeColor',cmap(ic,:));
end
xlabel('X');
ylabel('Y');
{% endhighlight %} 

![grouped](/assets/unsupervised/grouped_labeled_color.png)

----------------

Perform the unsupervised learning with parameter $$dc = 0.039290$$ (actually I tried a lot of $$dc$$ selected by datapercentage such as 22, 25, 28. The following is the best result gained). The learned results are:

{% highlight matlab %}
NUMBER OF CLUSTERS: 5 
Performing assignation
Calclate halo of the cluster
CLUSTER: 1 CENTER: 3 ELEMENTS: 4905 CORE: 4905 HALO: 0 
CLUSTER: 2 CENTER: 825 ELEMENTS: 1091 CORE: 1091 HALO: 0 
CLUSTER: 3 CENTER: 4263 ELEMENTS: 1241 CORE: 1179 HALO: 62 
CLUSTER: 4 CENTER: 8039 ELEMENTS: 1743 CORE: 1081 HALO: 662 
CLUSTER: 5 CENTER: 9252 ELEMENTS: 1020 CORE: 1020 HALO: 0 
{% endhighlight %} 

### Sci Versus Kmeans
![sci versus kmeans](/assets/unsupervised/kmeans-sc-label.png)

Groundtruth Profile

Code|Type of attack|Number
---|---|---
1|normal|2041
2|probe|82
3|denial of service (DOS)|7874
4|user-to-root (U2R)|2
5|remote-to-local (R2L)|1


### Sci histogram
![sci performance](/assets/unsupervised/sci.png)

### Kmeans histogram
![kmeans performance](/assets/unsupervised/kmeans.png)