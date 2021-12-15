#' alert with text color grey
#'
#' @param input input text string
#'
#' @family Style
#'
#' @export
alert_success_grey <- function(input) {
  cli::cli_alert_success("{text_style(input)}")
}

#' alert with text color grey
#'
#' @param input input text string
#'
#' @family Style
#'
#' @export
alert_info_grey <- function(input) {
  cli::cli_alert_info("{text_style(input)}")
}

#' text style with color grey
#'
#' @param input input text string
#'
#' @keywords internal
text_style <- function(input) {
  col_text <- cli::make_ansi_style("grey")

  col_text(input)
}
