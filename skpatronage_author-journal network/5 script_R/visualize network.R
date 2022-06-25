setwd("C:/Users/seoul/Dropbox/00 technical/github/lit-review-network/5 script_R")
getwd()

# references

# https://kateto.net/network-visualization

# install.packages("igraph") 
# install.packages("network") 
# install.packages("sna")
# install.packages("ggraph")
# install.packages("visNetwork")
# install.packages("threejs")
# install.packages("networkD3")
# install.packages("ndtv")


# import libraries
library(igraph)


# import node list and edge list
filepath.nodes <- "../4.3 data_edgelist and nodelists/nkelites_nodelist_combined.csv"
filepath.edges <- "../4.3 data_edgelist and nodelists/nkelites_edgelist_author_journal.csv"

nodes <- read.csv(filepath.nodes, header=T, as.is=T)
edges <- read.csv(filepath.edges, header=T, as.is=T)

nodes$NodeLabelColor<-nodes$NodeColor
nodes$NodeLabelColor[nodes$NodeColor=="White"]<-"Black"
nodes$NodeLabelColor[nodes$NodeColor=="Light Blue"]<-"Blue"

nodes$NodeLabelSize<-nodes$NodeSize
nodes$NodeLabelSize[nodes$NodeType=="Journal"]<-1.5




# create the network
net <- graph_from_data_frame(d=edges, vertices=nodes,directed=FALSE)
E(net)$weight <- edges$edgeweight
V(net)$type <- nodes$NodeType


# visualize network with colored circles and squares
p1<-plot(net,
     vertex.shape=tolower(V(net)$NodeShape),
     vertex.color=V(net)$NodeColor,
     vertex.size=5,
     vertex.label=V(net)$NodeLabel,
     vertex.label.cex=.17*V(net)$NodeLabelSize,
     vertex.label.degree=0,
     vertex.label.dist=2.5);p1

p1.1<-plot(net,
           vertex.shape=tolower(V(net)$NodeShape),
           vertex.color=V(net)$NodeColor,
           vertex.size=5,
           vertex.label=V(net)$NodeLabel,
           vertex.label.cex=.1*V(net)$NodeLabelSize);p1.1


# visualize network with colored labels
p2<-plot(net,
     vertex.shape="none",
     vertex.label=V(net)$NodeLabel,
     vertex.label.color=V(net)$NodeLabelColor,
     vertex.label.cex=.17*V(net)$NodeLabelSize);p2


# export figures as pdf file
pdf("../7 figures_networks/p1.pdf")
plot(net,
     vertex.shape=tolower(V(net)$NodeShape),
     vertex.color=V(net)$NodeColor,
     vertex.size=5,
     vertex.label=V(net)$NodeLabel,
     vertex.label.cex=.2*V(net)$NodeLabelSize,
     vertex.label.degree=0,
     vertex.label.dist=2.5)
dev.off()


pdf("../7 figures_networks/p1.1.pdf")
plot(net,
           vertex.shape=tolower(V(net)$NodeShape),
           vertex.color=V(net)$NodeColor,
           vertex.size=5,
           vertex.label=V(net)$NodeLabel,
           vertex.label.cex=.1*V(net)$NodeLabelSize)
dev.off()


pdf("../7 figures_networks/p2.pdf")
plot(net,
     vertex.shape="none",
     vertex.label=V(net)$NodeLabel,
     vertex.label.color=V(net)$NodeLabelColor,
     vertex.label.cex=.3*V(net)$NodeLabelSize)
dev.off()



