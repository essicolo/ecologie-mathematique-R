library(tidyverse)
library(ggExtra)
library(mvtnorm)
library(reshape2)

kernel <- function(a, b, param) {
  sqdist <- sum(a**2) + sum(b**2) - 2*(a %*% t(b))
  return(exp(-0.5 * (1/param) * sqdist))
}

n <- 2
p <- 1
x_star = matrix(seq(-5, 5, length=n), ncol=p)

cov_kernel <- kernel(a = x_star, b = x_star, param = 100)
cov_kernel

n_sim = 800
x_sim = as_tibble(rmvnorm(n_sim, mean = rep(0, n), sigma = cov_kernel))
names(x_sim) <- paste0('Dim', 1:n)


x_sim_sample <- sample_n(x_sim, 3)
x_sim_sample$sample = factor(1:nrow(x_sim_sample))
p <- ggplot(x_sim, aes(Dim1, Dim2)) +
  geom_point(alpha=0.25, size=3) +
  geom_point(data=x_sim_sample, aes(colour=sample), size=5) +
  theme_bw()
ggMarginal(p, type = "histogram")

x_melt <- melt(x_sim_sample, id.vars = 'sample')
x_melt$variable <- as.numeric(x_melt$variable)

ggplot(x_melt, aes(variable, value)) +
  geom_line(aes(colour=sample)) +
  geom_point(aes(colour=sample), size=5) +
  scale_x_continuous(breaks = 1:n) +
  xlab('Dimension') +
  ylab('x') +
  theme_bw()
  


kernel <- function(a, b, param) {
  sqdist <- sum(a**2) + sum(b**2) - 2*(a %*% t(b))
  return(exp(-0.5 * (1/param) * sqdist))
}

n <- 5
p <- 1
x_star = matrix(seq(-5, 5, length=n), ncol=p)

cov_kernel <- kernel(a = x_star, b = x_star, param = 10)
n_sim = 800
x_sim = as_tibble(rmvnorm(n_sim, mean = rep(0, n), sigma = cov_kernel))
names(x_sim) <- paste0('Dim', 1:n)
x_sim_sample <- sample_n(x_sim, 3)
x_sim_sample$sample = factor(1:nrow(x_sim_sample))
x_melt <- melt(x_sim_sample, id.vars = 'sample')
x_melt$variable <- as.numeric(x_melt$variable)

ggplot(x_melt, aes(variable, value)) +
  geom_line(aes(colour=sample)) +
  geom_point(aes(colour=sample), size=5) +
  #scale_x_continuous(breaks = 1:n) +
  xlab('Dimension') +
  ylab('x') +
  theme_bw()





n <- 500
p <- 1
x_star = matrix(seq(-5, 5, length=n), ncol=p)

cov_kernel <- kernel(a = x_star, b = x_star, param = 10)
n_sim = 800
x_sim = as_tibble(rmvnorm(n_sim, mean = rep(0, n), sigma = cov_kernel))
names(x_sim) <- paste0('Dim', 1:n)
x_sim_sample <- sample_n(x_sim, 50)
x_sim_sample$sample = factor(1:nrow(x_sim_sample))
x_melt <- melt(x_sim_sample, id.vars = 'sample')
x_melt$variable <- as.numeric(x_melt$variable)

ggplot(x_melt, aes(variable, value)) +
  geom_line(aes(colour=sample), alpha=0.5) +
  #geom_point(aes(colour=sample), size=5) +
  #scale_x_continuous(breaks = 1:n) +
  scale_colour_manual(values = rep('black', times=nrow(x_sim_sample))) +
  xlab('Dimension') +
  ylab('x') +
  theme_bw() +
  theme(legend.position = 'none')
