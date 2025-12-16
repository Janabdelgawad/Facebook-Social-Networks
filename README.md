# Facebook Network Analysis using igraph in R

This project performs a comprehensive **social network analysis** on a Facebook dataset using the `igraph` library in R. It covers data loading, graph construction, network properties, centrality measures, and visualization.

---

## Features

1. **Data Loading**

   * Reads edge list from a dataset file
   * Provides a preview of the loaded data

2. **Graph Construction**

   * Builds an undirected graph from edge data
   * Displays the number of nodes and edges
   * Plots the full graph

3. **Node Degree Analysis**

   * Computes node degrees
   * Lists top nodes by degree
   * Plots degree distribution histogram

4. **Average Degree**

   * Computes and reports the average degree of the network

5. **Special Graph Properties**

   * Checks if the graph is regular, complete, or bipartite

6. **Connectivity Analysis**

   * Checks if the graph is connected
   * Computes connected components and size of the largest component
   * Plots the largest connected component

7. **Matrix Representations**

   * Adjacency matrix
   * Laplacian matrix
   * Biadjacency/incidence matrix (if bipartite)

8. **Graph Representations**

   * Displays sample edge list and adjacency list

9. **Quantifying Social Structure**

   * Computes graph density
   * Computes global and local clustering coefficients
   * Plots local clustering coefficient distribution

10. **Centrality Measures**

    * Degree, closeness, betweenness, and eigenvector centrality
    * Lists top nodes for each centrality measure
    * Visualizes the graph by each centrality measure

---

## Requirements

* R (version >= 4.0)
* igraph package

Install igraph with:

```R
install.packages("igraph")
```

---

## Usage

1. Set your dataset path in the `read.table()` function.
2. Run the script step by step to see printed outputs and plots.
3. Analyze top nodes, degree distributions, and centrality visualizations.

---

## Outputs & Visualizations

* **Graph visualizations:** Full graph, largest connected component, and centrality-based layouts
* **Histograms:** Node degree distribution, local clustering coefficient distribution
* **Metrics:** Number of nodes/edges, graph density, clustering coefficients, connectivity info, and top nodes by centrality

---

## Notes

* The script assumes the dataset is properly formatted as an edge list.
* Graph visualizations may be dense for large networks; adjust vertex size for clarity.
* Some matrix representations (e.g., biadjacency) are only applicable if the graph is bipartite.

---

## Purpose

This analysis helps understand the **structural and functional properties** of a social network, identify **influential nodes**, and visualize the network structure for insights into social connectivity and clustering.
