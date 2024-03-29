% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/download_dataset_init.R
\name{dimension_file_init}
\alias{dimension_file_init}
\title{Create a function file in the R directory for a specific dimension file}
\usage{
dimension_file_init(dataset_id, author)
}
\arguments{
\item{dataset_id}{Dataset-ID with the following structure: XXYYY_ZZ
XX=SDMX-Classification
YYY=STATBOT_CODE
ZZZZ=CH FOR OVERALL COUNTRY CODE, OR YOUR 2-LETTER CANTONAL CODE OR FOUR DIGITS BFS-COMMUNAL-CODE}

\item{author}{Name of the creator}
}
\description{
Create a function file in the R directory for a specific dimension file
}
\examples{
\dontrun{
download_datast_init(99999_99, "Thomas Knecht")
}

}
