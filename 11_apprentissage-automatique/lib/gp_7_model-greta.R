distribution(heartrate_1$bpm) <- normal(mean, sd)
m <- model(mean, sd)
draws <- mcmc(m, n_samples = 500)
