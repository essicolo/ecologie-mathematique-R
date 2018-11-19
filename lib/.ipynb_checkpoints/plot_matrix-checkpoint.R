plot_matrix = function(covariance_mat, cex=1) {
  delta <- 2/(ncol(covariance_mat)-1)
  plot(0,type='n', xlim=c(-1.2, 1.2), ylim=c(-1.2, 1.2), axes=FALSE,ann=FALSE) # 
  lines(c(-1, -1.1, -1.1, -1), c(1.15, 1.15, -1.15, -1.15))
  lines(c(1, 1.1, 1.1, 1), c(1.15, 1.15, -1.15, -1.15))
  for (i in 1:ncol(covariance_mat)) {
    for (j in 1:nrow(covariance_mat)) {
      text(delta*(i-1)-1, 1-delta*(j-1), round(covariance_mat, 2)[i, j], cex=cex)
    }
  }
}