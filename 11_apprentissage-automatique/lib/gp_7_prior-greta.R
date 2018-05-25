library(greta) # Probabilistic Modelling with TensorFlow
mean <- normal(70, 5) # a priori sur la moyenne
sd <- student(3, 0, 1, truncation = c(0, Inf)) # a priori sur l'écart-type
