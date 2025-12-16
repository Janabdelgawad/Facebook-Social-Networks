library(igraph)

cat("\n==================== 1. LOADING DATA ====================\n")

# Load edges file
edges <- read.table(
  "D:/_Semester 7/intro to social networks/project/facebook_combined.txt/dataset_with_nodes_and_edges.txt",
  header = FALSE
)

colnames(edges) <- c("nodes", "edges")

cat("Preview of dataset:\n")
print(head(edges))

cat("\n==================== 2. BUILDING GRAPH ====================\n")

g <- graph_from_data_frame(edges, directed = FALSE)

cat("Graph successfully created!\n")
cat("Number of nodes: ", vcount(g), "\n")
cat("Number of edges: ", ecount(g), "\n")

# Initial plot
plot(
  g,
  vertex.size = 2,
  vertex.label = NA,
  edge.color = "gray70",
  main = "Facebook Social Network (Full Graph)"
)


###############################################################
#                 3. DEGREE ANALYSIS
###############################################################

cat("\n==================== 3. NODE DEGREE ====================\n")

node_degree <- degree(g)

cat("Top 10 highest degree nodes:\n")
print(head(sort(node_degree, decreasing = TRUE), 10))

# Visualization: Degree Distribution Histogram
hist(
  node_degree,
  breaks = 50,
  main = "Node Degree Distribution",
  xlab = "Degree",
  ylab = "Frequency"
)


###############################################################
#                 4. AVERAGE DEGREE
###############################################################

cat("\n==================== 4. AVERAGE DEGREE ====================\n")

avg_deg <- mean(node_degree)

cat("Average degree of the network is: ", avg_deg, "\n")


###############################################################
#                 5. SPECIAL GRAPH PROPERTIES
###############################################################

cat("\n==================== 5. SPECIAL GRAPH PROPERTIES ====================\n")

# Regular graph check
is_regular <- function(graph) {
  deg <- degree(graph)
  return(length(unique(deg)) == 1)
}

# Complete graph check
is_complete <- function(graph) {
  n <- vcount(graph)
  deg <- degree(graph)
  return(all(deg == (n - 1)))
}

cat("Is the graph regular? ", is_regular(g), "\n")
cat("Is the graph complete? ", is_complete(g), "\n")
cat("Is the graph bipartite? ", is_bipartite(g), "\n")


###############################################################
#                 6. CONNECTIVITY
###############################################################

cat("\n==================== 6. CONNECTIVITY ====================\n")

cat("Is the graph connected? ", is_connected(g), "\n")

comps <- components(g)

cat("Number of connected components: ", comps$no, "\n")
cat("Size of largest component: ", max(comps$csize), "\n")

# Plot Largest Connected Component
g_lcc <- induced_subgraph(g, which(comps$membership == which.max(comps$csize)))

plot(
  g_lcc,
  vertex.size = 2,
  vertex.label = NA,
  main = "Largest Connected Component"
)


cat("\n==================== 7. MATRIX REPRESENTATIONS ====================\n")

# Adjacency Matrix
adj_matrix <- as.matrix(as_adjacency_matrix(g))
cat("Adjacency Matrix Dimensions: ", dim(adj_matrix), "\n")

# Laplacian Matrix
lap_matrix <- laplacian_matrix(g)
cat("Laplacian Matrix Dimensions: ", dim(lap_matrix), "\n")

# Incidence/Biadjacency Matrix
if (is_bipartite(g)) {
  bi_matrix <- as_biadjacency_matrix(g)
  cat("Biadjacency Matrix Dimensions: ", dim(bi_matrix), "\n")
} else {
  cat("Graph is NOT bipartite → incidence/biadjacency matrix not applicable.\n")
}

###############################################################
#                 8. GRAPH REPRESENTATIONS
###############################################################

cat("\n==================== 8. GRAPH REPRESENTATIONS ====================\n")

cat("Sample Edge List:\n")
print(head(get.edgelist(g)))

cat("\nSample Adjacency List for node 1:\n")
print(adjacent_vertices(g, V(g)[1]))


###############################################################
#                 9. QUANTIFYING SOCIAL STRUCTURE
###############################################################

cat("\n==================== 9. QUANTIFYING SOCIAL STRUCTURE ====================\n")

density_val <- edge_density(g)
global_clust <- transitivity(g, type = "global")
local_clust <- transitivity(g, type = "local")

cat("Graph Density: ", density_val, "\n")
cat("Global Clustering Coefficient: ", global_clust, "\n")

# Visualization: Local Clustering Coefficient Distribution
hist(
  local_clust,
  breaks = 50,
  main = "Local Clustering Distribution",
  xlab = "Clustering Coefficient",
  ylab = "Frequency"
)


###############################################################
#                 10. CENTRALITY MEASURES
###############################################################

cat("\n==================== 10. CENTRALITY MEASURES ====================\n")

# Compute centrality measures
deg_c <- degree(g)
close_c <- closeness(g)
betw_c <- betweenness(g)
eig_c <- eigen_centrality(g)$vector

centrality_df <- data.frame(
  node = V(g)$name,
  degree = deg_c,
  closeness = close_c,
  betweenness = betw_c,
  eigenvector = eig_c
)

# Top nodes
cat("Top 5 nodes by degree:\n")
print(head(sort(deg_c, decreasing = TRUE), 5))

cat("Top 5 nodes by closeness:\n")
print(head(sort(close_c, decreasing = TRUE), 5))

cat("Top 5 nodes by betweenness:\n")
print(head(sort(betw_c, decreasing = TRUE), 5))

cat("Top 5 nodes by eigenvector centrality:\n")
print(head(sort(eig_c, decreasing = TRUE), 5))

# ---- VISUALIZATIONS ----

# Degree centrality
plot(g,
     vertex.size = (deg_c / max(deg_c)) * 12 + 2,
     vertex.label = NA,
     main = "Graph Visualization by Degree Centrality")

# Closeness centrality
plot(g,
     vertex.size = (close_c / max(close_c)) * 12 + 2,
     vertex.label = NA,
     main = "Graph Visualization by Closeness Centrality")

# Betweenness centrality
plot(g,
     vertex.size = (betw_c / max(betw_c)) * 12 + 2,
     vertex.label = NA,
     main = "Graph Visualization by Betweenness Centrality")

# Eigenvector centrality
plot(g,
     vertex.size = (eig_c / max(eig_c)) * 12 + 2,
     vertex.label = NA,
     main = "Graph Visualization by Eigenvector Centrality")


