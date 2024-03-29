.qminerals <- function(x, xrd_lib) {

  #Restrict the xrd library to phases within the names of x
  minerals <- xrd_lib$phases

  minerals <- minerals[which(minerals$phase_id %in% names(x)),]

  #make sure the minerals data frame is in the same order as x
  minerals <- minerals[match(names(x), minerals$phase_id),]

  if(!identical(names(x), minerals$phase_id)) {

    stop("The phase ID's for quantification do not match the names of the scaling coefficients.")

  }

  minerals$phase_percent <- (x/minerals$rir)/sum(x/minerals$rir)*100

  #df <- data.frame(minerals, "phase_percent" = min_percent)
  row.names(minerals) = c(1:nrow(minerals))

  minerals$phase_order <- c(1:nrow(minerals))

  #Summarise by summing the concentrations from each mineral group

  minerals_g <- data.frame(stats::aggregate(phase_percent ~ phase_name, data = minerals, FUN = sum),
                    stringsAsFactors = FALSE)

  minerals_o <- data.frame(stats::aggregate(phase_order ~ phase_name, data = minerals, FUN = mean),
                           stringsAsFactors = FALSE)

  minerals_g <- plyr::join(minerals_g, minerals_o, by = "phase_name")

  minerals_g <- minerals_g[order(minerals_g$phase_order),]

  row.names(minerals_g) <- c(1:nrow(minerals_g))

  minerals$phase_order <- NULL
  minerals_g$phase_order <- NULL

  #Ensure that the phase concentrations are rounded to 4 dp
  minerals$phase_percent <- round(minerals$phase_percent, 4)
  minerals_g$phase_percent <- round(minerals_g$phase_percent, 4)

  out <- list("df" = minerals, "dfs" = minerals_g)

  return(out)
}

.qminerals2 <- function(x, xrd_lib, std, std_conc, closed) {

  if (missing(closed)) {

    closed <- FALSE

  }

  #Get the name of the internal standard
  std_name <- xrd_lib$phases$phase_name[which(xrd_lib$phases$phase_id == std)]

  #Extract all the ids of potential standard patterns
  std_ids <- xrd_lib$phases$phase_id[which(xrd_lib$phases$phase_name == std_name)]

  id_match <- which(names(x) %in% std_ids)

  if (length(id_match) < 1) {

    stop("\n-The phase specified as the std is not present. Cannot compute
         phase concentrations.")

  }

  #Get the scaling parameter of x
  std_x <- sum(x[which(names(x) %in% std_ids)])

  minerals <- xrd_lib$phases
  minerals <- minerals[which(minerals$phase_id %in% names(x)),]

  #Calculate a weighted average rir
  std_rir <- sum((minerals$rir[which(minerals$phase_id %in% std_ids)]/
                    std_x) * x[which(names(x) %in% std_ids)])

  #Restrict the xrd library to phases within the names of X
  minerals <- minerals[which(minerals$phase_id %in% names(x)),]

  #make sure the minerals data frame is in the same order as x
  minerals <- minerals[match(names(x), minerals$phase_id),]


  if(!identical(names(x), minerals$phase_id)) {

    stop("The phase ID's for quantification do not match the names of the scaling coefficients.")

  }


  min_percent <- c()

  for (i in 1:length(x)) {

    min_percent[i] <- (std_conc/(minerals$rir[i]/std_rir)) * (x[i]/std_x)

  }


  minerals$phase_percent <- min_percent
  row.names(minerals) = c(1:nrow(minerals))

  minerals$phase_order <- c(1:nrow(minerals))

  if (closed == TRUE) {

    cat("\n-Removing internal standard concentration and normalising to 100 %")
    minerals <- minerals[-which(minerals$phase_name == std_name),]
    minerals$phase_percent <- minerals$phase_percent / sum(minerals$phase_percent) * 100

  }

  minerals_g <- data.frame(stats::aggregate(phase_percent ~ phase_name, data = minerals, FUN = sum),
                           stringsAsFactors = FALSE)

  minerals_o <- data.frame(stats::aggregate(phase_order ~ phase_name, data = minerals, FUN = mean),
                           stringsAsFactors = FALSE)

  minerals_g <- plyr::join(minerals_g, minerals_o, by = "phase_name")

  minerals_g <- minerals_g[order(minerals_g$phase_order),]

  row.names(minerals_g) <- c(1:nrow(minerals_g))

  minerals$phase_order <- NULL
  minerals_g$phase_order <- NULL


  #Ensure that the phase concentrations are rounded to 4 dp
  minerals$phase_percent <- round(minerals$phase_percent, 4)
  minerals_g$phase_percent <- round(minerals_g$phase_percent, 4)

  out <- list("df" = minerals, "dfs" = minerals_g)

  return(out)
}
