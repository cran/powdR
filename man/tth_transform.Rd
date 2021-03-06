% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tth_transform.R
\name{tth_transform}
\alias{tth_transform}
\title{Transform a two theta axis between wavelengths}
\usage{
tth_transform(tth, from, to)
}
\arguments{
\item{tth}{the 2theta vector to be transformed}

\item{from}{numeric value defining the wavelength (Angstroms) to transform from}

\item{to}{numeric value defining the wavelength (Angstroms) to transform to}
}
\value{
a transformed 2theta vector
}
\description{
\code{tth_transform} converts the two theta axis from one wavelength to another via Bragg's law.
Use this function with caution if intending the apply \code{fps()} or \code{afps()} to wavelength
transformed samples or libraries because background signals can vary with wavelength which may
therefore affect the quality of the fit.
}
\examples{
data(soils)
sandstone2 <- soils$sandstone

#Convert from Cu (1.54056 Angstroms) to Co (1.78897 Angstroms)
sandstone2$tth <- tth_transform(sandstone2$tth,
                                from = 1.54056,
                                to = 1.78897)
#plot the change
plot(soils$sandstone, type = "l",
     xlim = c(0, 85))
lines(sandstone2, col = "red")

#Alternatively convert the 2theta axis of a library
data(minerals)

minerals2 <- minerals
minerals2$tth <- tth_transform(minerals2$tth,
                                from = 1.54056,
                                to = 1.78897)

#Plot the difference
plot(x = minerals$tth, y = minerals$xrd$QUA.1,
     type = "l", xlim = c(0, 85))
lines(x = minerals2$tth, y = minerals2$xrd$QUA.1,
      col = "red")
}
