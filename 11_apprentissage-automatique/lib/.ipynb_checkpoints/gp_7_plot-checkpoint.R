x_prior <- seq(50, 80, length=100)
y_prior <- dnorm(x_prior,
              mean = 65,
              sd = 5)
x_post <- seq(50, 80, length=100)
y_post <- dnorm(x_post,
              mean = summary(draws)[[1]][1, 1],
              sd = summary(draws)[[1]][1, 2])

png('images/gp_7_plot.png', width=600, height=400, res=120)
par(mar=c(4, 4, 1, 1))
plot(x_prior, y_prior, type='l', col="red", ylim=c(0, 0.2),
    xlab = "Heart rate at 7:00 (bpm)", ylab = "Density")
grid()
lines(x_post, y_post, col="green")
points(x=heartrate_1$bpm, y=rep(0, nrow(heartrate_1)))
legend("topright", legend = c("prior", "posterior"),
       col=c("red", "green"),
      lty=c(1, 1))
dev.off()
