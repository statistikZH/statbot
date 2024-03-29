% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/download_dataset_init.R
\name{download_dataset_init}
\alias{download_dataset_init}
\title{Create a function file in the R directory for a specific dataset download}
\usage{
download_dataset_init(dataset_id, author)
}
\arguments{
\item{dataset_id}{Dataset-ID with the following structure: XXYYY_ZZ
XX=SDMX-Classification
YYY=STATBOT_CODE
ZZZZ=CH FOR OVERALL COUNTRY CODE, OR YOUR 2-LETTER CANTONAL CODE OR FOUR DIGITS BFS-COMMUNAL-CODE}

\item{author}{Name of the creator}
}
\description{
Create a function file in the R directory for a specific dataset download
}
\examples{
\dontrun{
download_datast_init(99999_99, "Thomas Knecht")
}

}
