library("compositions")
data("ArcticLake")
source('https://raw.githubusercontent.com/essicolo/AgFun/master/ilrDefinition.R')

rotate <- function(xy, deg, center = c(0, 0)) {
  xy <- unclass(xy)
  alpha <- -deg*pi/180 # rotation angle
  rotm <- matrix(c(cos(alpha),sin(alpha),-sin(alpha),cos(alpha)),ncol=2) #rotation matrix
  rotated <- t(rotm %*% (t(xy) - center) + center)
  return(rotated)
}

circle <- function(rad = 1, center = c(0, 0), npoints = 100) {
  seqc <- seq(0, 2*pi, length=npoints)
  circ <- t(rbind(center[1] + sin(seqc)*rad, center[2] + cos(seqc)*rad)) 
  return(circ)
}

arrowBal <- function(labels, deg = 0, rad = 1, center = c(0,0), pos = c(1, 1), color = "black") {
  x0 <- center[1]
  x1 <- cos(deg*pi/180)*rad + center[1]
  x2 <- cos((deg+90)*pi/180)*rad + center[1]
  y0 <- center[2]
  y1 <- sin(deg*pi/180)*rad + center[2]
  y2 <- sin((deg+90)*pi/180)*rad + center[2]
  arrows(x0, y0, x1, y1, col = color)
  text(x1, y1, labels = labels[1], pos = pos[1], col = color, cex = 0.8)
  arrows(x0, y0, x2, y2, col = color)
  text(x2, y2, labels = labels[2], pos = pos[2], col = color, cex = 0.8)
}

parts <- ArcticLake[, 1:3]
comp <- acomp(parts)

sbp1 <- matrix(c( 1,-1,-1,
                  0, 1,-1),
               byrow = TRUE,
               ncol = 3)
sbp2 <- matrix(c(-1,-1, 1,
                 1,-1, 0),
               byrow = TRUE,
               ncol = 3)
sbp3 <- matrix(c( 1,-1, 1,
                  1, 0,-1),
               byrow = TRUE,
               ncol = 3)
colnames(sbp1) <- colnames(parts)
colnames(sbp2) <- colnames(parts)
colnames(sbp3) <- colnames(parts)

bal1 <- ilr(comp, V = gsi.buildilrBase(t(sbp1)))
bal2 <- ilr(comp, V = gsi.buildilrBase(t(sbp2)))
bal3 <- ilr(comp, V = gsi.buildilrBase(t(sbp3)))
colnames(bal1) <- ilrDefinition(sbp1, side = "-+")
colnames(bal2) <- ilrDefinition(sbp2, side = "-+")
colnames(bal3) <- ilrDefinition(sbp3, side = "-+")

colset <- c("#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e",
           "#e6ab02", "#a6761d", "#666666")

png(filename = "images/06_ilr-rotation.png", width = 1200, height = 600, res = 120)
par(mar = c(4,4,1,1), mfrow = c(1, 2))
plot(unclass(bal1), xlim = c(-4, 4), ylim = c(-4, 4), col = colset[1], cex=1, pch = 1,
     xlab = "ilr 1", ylab = "ilr 2")
abline(v=0, col = "grey70")
abline(h=0, col = "grey70")
points(unclass(bal2), col = colset[2], pch = 3, cex = 0.75)
points(unclass(bal3), col = colset[3], pch = 4, cex = 0.75)

plot(unclass(bal1), xlim = c(-4, 4), ylim = c(-4, 4), col = colset[1], cex=1, pch = 1,
     xlab = 'Rotated ilr1', ylab = 'Rotated ilr2')
abline(v=0, col = "grey70")
abline(h=0, col = "grey70")
points(rotate(bal2, deg = 120), col = colset[2], cex = 0.75, pch = 3) # rotate 240 deg
points(rotate(bal3, deg = 60), col = colset[3], cex = 0.75, pch = 4) # rotate 300 deg
rad = 2
lines(circle(rad = rad))
arrowBal(labels = colnames(bal1), deg = 0, rad = rad, pos = c(4,3), color = colset[1])
arrowBal(labels = colnames(bal2), deg = 120, rad = rad, pos = c(2,2), color = colset[2])
arrowBal(labels = colnames(bal3), deg = 60, rad = rad, pos = c(4,2), color = colset[3])
dev.off()
