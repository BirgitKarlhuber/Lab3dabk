#' Algorithm to find the shortest path from an initial node to all other nodes in a graph
#' 
#' The algorithm takes a graph and an initial node and calculates the shortest path from the initial node to every other node in the graph.
#'
#' @param graph data.frame with three variables (v1, v2 and w) that contains the 
#' edges of the graph (from v1 to v2) with the weight of the edge (w).
#' 
#' @param init_node A number corresponding to the start node
#'
#' @return The shortest path to every other node from the starting node as a vector.
#' 
#' @export
#' 
#' @examples
#' library(Lab3dabk)
#' dijkstra(wiki_graph, 1)
#' 
#' @seealso \url{https://en.wikipedia.org/wiki/Dijkstra’s_algorithm}


dijkstra <- function(graph, init_node){
  stopifnot(is.data.frame(graph), is.numeric(init_node), ncol(graph) == 3,
            all(names(graph) == c("v1","v2","w")), 
            init_node %in% unique(graph[[2]]))
  
  # idea: https://www.algorithms-and-technologies.com/dijkstra/r
  
  num_nodes <- length(unique(graph[[2]])) # get the number of nodes/vertex
  
  # create a matrix of the distances
  data <- matrix(Inf,nrow = num_nodes, ncol = num_nodes)
  diag(data) <- 0
  
  for(i in 1:nrow(graph)){
    data[graph$v1[i],graph$v2[i]] <- graph$w[i]
  }
  
  # initialize vectors for shortest distance and previously visited
  dist <- rep(Inf,nrow(data))
  prev <- rep(FALSE, nrow(data))
  
  dist[init_node] <- 0 # distance from the starting node to itself - zero
  
  repeat{
    # find node with the currently shortest distance from the initial node
    short_dist <- Inf
    short_index <- -1
    
    for(i in 1:num_nodes) {
      if(dist[i] < short_dist && !prev[i]){
        short_dist <- dist[i]
        short_index <- i
      }
    }
    
    if(short_index == -1){
      # we already visited all nodes -> return dist-vector
      return(dist)
      break
    } else {
      
      # for all neighbor-nodes we have not visited so far
      for(i in 1:length(data[short_index,])) {
        if(data[short_index,i] != 0 && dist[i] > (dist[short_index] + data[short_index,i])){
      
          dist[i] = dist[short_index] + data[short_index,i] # this is the new shortest path
        }
        prev[short_index] = TRUE # set "prev" to TRUE for the current node
      }
    }
  }
}
