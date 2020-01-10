## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- message = FALSE, warning = FALSE----------------------------------------
library(powdR)

data(minerals_xrd)

head(minerals_xrd[1:9])

## ---- message = FALSE, warning = FALSE----------------------------------------
data(minerals_phases)

minerals_phases[1:8,]

## ---- message = FALSE, warning = FALSE----------------------------------------
identical(names(minerals_xrd[-1]),
          minerals_phases$phase_id)

## ---- message = FALSE, warning = FALSE----------------------------------------
my_lib <- powdRlib(minerals_xrd, minerals_phases)

plot(my_lib, wavelength = "Cu",
     refs = c("ALB", "DOL.1",
              "QUA.1", "GOE.2"))

## ---- message = FALSE, warning = FALSE----------------------------------------
data(rockjock)

#Have a look at the phase ID's in rockjock
rockjock$phases$phase_id[1:10]

#Remove reference patterns from rockjock
rockjock_1 <- subset(rockjock,
                     refs = c("ALUNITE", #phase ID
                              "AMPHIBOLE", #phase ID
                              "ANALCIME", #phase ID
                              "Plagioclase"), #phase name
                     mode = "remove")

#Check number of reference patterns remaining in library
nrow(rockjock_1$phases)

#Keep certain reference patterns of rockjock
rockjock_2 <- subset(rockjock,
                     refs = c("ALUNITE", #phase ID
                              "AMPHIBOLE", #phase ID
                              "ANALCIME", #phase ID
                              "Plagioclase"), #phase name
                     mode = "keep")

#Check number of reference patterns remaining
nrow(rockjock_2$phases)

## ---- message = FALSE, warning = FALSE----------------------------------------
data("rockjock_mixtures")

fit_1 <- fps(lib = rockjock,
             smpl = rockjock_mixtures$Mix1,
             refs = c("ORDERED_MICROCLINE",
                      "LABRADORITE",
                      "KAOLINITE_DRY_BRANCH",
                      "MONTMORILLONITE_WYO",
                      "ILLITE_1M_RM30",
                      "CORUNDUM"),
             std = "CORUNDUM",
             std_conc = 20,
             align = 0.3)

## ---- message = FALSE, warning = FALSE----------------------------------------
fit_1$phases

## ---- message = FALSE, warning = FALSE----------------------------------------
sum(fit_1$phases$phase_percent)

## ---- message = FALSE, warning = FALSE----------------------------------------
fit_2 <- fps(lib = rockjock,
             smpl = rockjock_mixtures$Mix5,
             refs = c("ORDERED_MICROCLINE",
                      "LABRADORITE",
                      "KAOLINITE_DRY_BRANCH",
                      "MONTMORILLONITE_WYO",
                      "CORUNDUM",
                      "QUARTZ"),
             std = "QUARTZ",
             std_conc = 20,
             align = 0.3)

fit_2$phases

sum(fit_2$phases$phase_percent)

## ---- message = FALSE, warning = FALSE----------------------------------------
fit_3 <- fps(lib = rockjock,
             smpl = rockjock_mixtures$Mix1,
             refs = c("ORDERED_MICROCLINE",
                      "LABRADORITE",
                      "KAOLINITE_DRY_BRANCH",
                      "MONTMORILLONITE_WYO",
                      "ILLITE_1M_RM30",
                      "CORUNDUM"),
             std_conc = NA,
             std = "CORUNDUM",
             align = 0.3)

## ---- message = FALSE, warning = FALSE----------------------------------------
fit_3$phases

## ---- message = FALSE, warning = FALSE----------------------------------------
sum(fit_3$phases$phase_percent)

## ---- message = FALSE, warning = FALSE----------------------------------------
#Create a sample with a shorter 2theta axis than the library
Mix1_short <- subset(rockjock_mixtures$Mix1, tth > 10 & tth < 55)

#Reduce the resolution by selecting only odd rows of the data
Mix1_short <- Mix1_short[seq(1, nrow(Mix1_short), 2),]

fit_4 <- fps(lib = rockjock,
             smpl = Mix1_short,
             refs = c("ORDERED_MICROCLINE",
                      "LABRADORITE",
                      "KAOLINITE_DRY_BRANCH",
                      "MONTMORILLONITE_WYO",
                      "ILLITE_1M_RM30",
                      "CORUNDUM"),
             std = "CORUNDUM",
             align = 0.3)

fit_4$phases

## ---- message = FALSE, warning = FALSE----------------------------------------
fit_5 <- afps(lib = rockjock,
              smpl = rockjock_mixtures$Mix1,
              std = "CORUNDUM",
              align = 0.3,
              lod = 1)

fit_5$phases_grouped

## ---- message = FALSE, warning = FALSE----------------------------------------
plot(fit_5, wavelength = "Cu")

## ---- message = FALSE, warning = FALSE----------------------------------------
multi_fit <- lapply(rockjock_mixtures[1:3], fps,
                    lib = rockjock,
                    std = "CORUNDUM",
                    refs = c("ORDERED_MICROCLINE",
                             "LABRADORITE",
                             "KAOLINITE_DRY_BRANCH",
                             "MONTMORILLONITE_WYO",
                             "ILLITE_1M_RM30",
                             "CORUNDUM",
                             "QUARTZ"),
                    align = 0.3)

names(multi_fit)

## ---- message = FALSE, warning = FALSE----------------------------------------
summarise_mineralogy(multi_fit, type = "grouped", order = TRUE)

