% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/search_datasets.R
\name{search_datasets}
\alias{search_datasets}
\title{Search datasets}
\usage{
search_datasets(query = "", source = "", sector = "", region = "",
  aoi = FALSE)
}
\arguments{
\item{query}{Character, specifying the search query.}

\item{source}{Character, specifying the name of data sources.}

\item{sector}{Character, specifying the sector in which the search will be aplied.}

\item{region}{Character, region code, e.g. 'US'.}

\item{aoi}{Logical, wheter the search should be limited to the specified aoi or not.}
}
\value{
Dataframe, containing information about all matching datasets.
}
\description{
\code{seearch_datasets} searches Esri's Open Data Hub using its REST API by applying
the specified filters. If an aoi is set by exacuting set_aoi(), results can be also
limited to a certain bounding box area.
}
\examples{
library(esriOpenData)
datasets <- search_datasets("Census 2011", "statista", "Demography", "GER", aoi = T)

}
\author{
Sandro Groth
}
\keyword{search_datasets}
