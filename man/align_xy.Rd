% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/align_xy.R
\name{align_xy}
\alias{align_xy}
\title{Align XRPD data to a given standard}
\usage{
align_xy(x, std, xmin, xmax, xshift, ...)
}
\arguments{
\item{x}{an \code{XY} or \code{multiXY} object.}

\item{std}{a dataframe of the chosen standard that each
sample will be aligned to (column 1 = 2theta, column 2 = counts)}

\item{xmin}{the minimum 2theta value used during alignment}

\item{xmax}{the maximum 2theta value used during alignment}

\item{xshift}{the maximum (positive and negative) 2theta shift
that is allowed during alignment}

\item{...}{other arguments}
}
\value{
an \code{XY} or \code{multiXY} object.
}
\description{
See \code{?align_xy.XY} and \code{align_xy.multiXY} for
method-specific details.
}
\examples{
# Load soils xrd data
data(soils)

#Load minerals library
data(minerals)

\dontrun{
#Create a standard quartz pattern to align to
quartz <- data.frame(tth = minerals$tth,
                     counts = minerals$xrd$QUA.1)

#Plot the main quartz peak prior to alignment
plot(soils, wavelength = "Cu",
     xlim = c(26,27),
     normalise = TRUE)

#align data
aligned <- align_xy(soils,
                    std = quartz,
                    xmin = 10,
                    xmax = 60,
                    xshift = 0.2)

#replot data
plot(aligned, wavelength = "Cu",
     xlim = c(26,27),
     normalise = TRUE)

#Alternatively try with a single XY object

unaligned <- as_multi_xy(list("quartz" = quartz,
                             "sandstone" = soils$sandstone))

plot(unaligned, wav = "Cu",
     xlim = c(26,27), normalise = TRUE)

sandstone_a <- align_xy(soils$sandstone,
                        std = quartz,
                        xmin = 10,
                        xmax = 60,
                        xshift = 0.3)

aligned <- as_multi_xy(list("quartz" = quartz,
                            "sandstone" = sandstone_a))

plot(aligned, wav = "Cu",
     xlim = c(26,27), normalise = TRUE)

}

}
