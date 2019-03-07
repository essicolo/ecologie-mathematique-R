png("images/09_exercice-plot.png", width = 1000, height = 1300, res = 90)
plot_grid(autoplot(hydrometeo_monthly_ts[, 1]) + ggtitle("A: Série temporelle") + labs(y = "Débit"),
          autoplot(hydrometeo_monthly_ts[, 2]) + ggtitle("B: Série temporelle") + labs(y = "tota_precip"),
          autoplot(hydrometeo_monthly_ts[, 3]) + ggtitle("C: Série temporelle") + labs(y = "mean_temp"),
          ggAcf(hydrometeo_monthly_ts[, 2]) + ggtitle("A: Autocorrélation"),
          ggAcf(hydrometeo_monthly_ts[, 1]) + ggtitle("B: Autocorrélation"),
          ggAcf(hydrometeo_monthly_ts[, 3]) + ggtitle("C: Autocorrélation"),
          gglagplot(hydrometeo_monthly_ts[, 2]) + ggtitle("A: Lag plot"),
          gglagplot(hydrometeo_monthly_ts[, 3]) + ggtitle("B: Lag plot"),
          gglagplot(hydrometeo_monthly_ts[, 1]) + ggtitle("C: Lag plot"),
          ncol = 3)
dev.off()