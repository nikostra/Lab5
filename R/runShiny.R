#' Runs the shiny app to demonstrate the compare_inhabitants function visually
#' @import shiny
#' @export
#' 
runShiny <- function() {
  appDir <- system.file("shinyapp", package = "Lab5")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}
