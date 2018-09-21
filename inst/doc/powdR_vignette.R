## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- fig.show='hold', fig.cap = "**Figure 1:** The resulting fit on a sandstone soil when `fps` is applied using a single quartz reference pattern. The top plot displays the measured and fitted patterns, and the bottom plots displays the residuals.", message = FALSE, warning = FALSE----
library(powdR)

data(minerals)
data(soils)

#Apply summation to the sandstone sample, with quartz as the only mineral
fit <- fps(lib = minerals,
           smpl = soils$sandstone,
           refs = "QUA.1",
           std = "QUA.1",
           align = 0.2)

#plot the data to interpret the fit
plot(fit)

## ---- fig.show='hold', fig.cap = "**Figure 2:** The resulting full pattern fit on a sandstone soil when `fps` is applied using reference patterns from quartz and organic matter.", message = FALSE, warning = FALSE----
#Apply fps to the sandstone sample with quartz (crystalline) and organic matter (amorphous)
fit <- fps(lib = minerals,
           smpl = soils$sandstone,
           refs = c("QUA.1", "ORG"),
           std = "QUA.1",
           align = 0.2)

#plot the data to interpret the fit
plot(fit)

## ---- fig.show='hold', fig.cap = "**Figure 3:** The resulting full pattern fit on a sandstone soil when `fps` is applied using reference patterns from quartz (2 different standards), kaolinite, plagioclase, K-feldspar and organic matter", message = FALSE, warning = FALSE----
#Apply fps to the sandstone sample, adding kaolinite, feldspar and oligoclase to the process
fit <- fps(lib = minerals,
           smpl = soils$sandstone,
           refs = c("QUA.1",
                    "QUA.2",
                    "KAO",
                    "FEL",
                    "OLI"),
           std = "QUA.1",
           align = 0.2)

#plot the data to interpret the fit
plot(fit)

## ------------------------------------------------------------------------
#returns individual contributions from each reference pattern
fit$phases

#returns summed contributions from each mineral
fit$phases_summary

