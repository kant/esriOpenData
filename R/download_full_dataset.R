#' Download full dataset
#'
#' \code{download_full_dataset} downloads a selected dataset from the server and saves it in the specified
#' output directory. Supported formats are: .shp, .kml and .csv
#'
#' @param sel_dataset Dataframe containing the information about a selected dataset.
#' @param format Character. Specifies the output format. Default is "shp".
#'
#' @return Logical, indicating success of the download operation.
#'
#' @examples
#' datasets <- search_datasets("Climate", aoi = T)
#' selected <- select_dataset(datasets, 12)
#' download_full_dataset(selected, format = "csv")
#'
#' @author Sandro Groth
#'
#' @importFrom downloader download
#'
#' @keywords download
#' @export

download_full_dataset <- function(sel_dataset, format="shp") {
  if(!is.data.frame(sel_dataset)) {msg("sel_dataset has to be of type data.frame.", "ERROR")}
  if(!"id" %in% colnames(sel_dataset)) {msg("sel_dataset has no column 'id'.", "ERROR")}
  if(!"url" %in% colnames(sel_dataset)) {msg("sel_dataset has no column 'url'.", "ERROR")}
  if(!format %in% c("shp", "csv", "kml")) {msg("Supported formats are only: shp, csv, kml", "ERROR")}
  if(!sel_dataset$dataType == "Layer") {msg(paste0("selected datatype is currently not supported: ", sel_dataset$dataType), "ERROR")}

  url <- paste0(getOption("esriOpenData.hub_base"), getOption("esriOpenData.api_dataset_endpoint"))
  url <- paste0(url, "/", sel_dataset$id)

  if(format == "shp") {url <- paste0(url, ".zip")}
  if(format == "kml") {url <- paste0(url, ".kml")}
  if(format == "csv") {url <- paste0(url, ".csv")}

  slug <- sel_dataset$slug
  slug <- gsub(":", "", slug)
  slug <- gsub("-", "_", slug)

  out_dir <- ""
  if(isFALSE(getOption("esriOpendata.out_dir_set"))) {
    msg("No output directory set. Working directory will be selected.")
    out_dir <- getwd()
  } else {
    out_dir <- getOption("esriOpenData.out_dir")
  }

  os <- .get_OS()
  tryCatch({
    if(os != "windows") {
      if(format == "shp") {downloader::download(url, destfile = paste0(out_dir, "/", slug, ".zip"))}
      if(format == "kml") {downloader::download(url, destfile = paste0(out_dir, "/", slug, ".kml"))}
      if(format == "csv") {downloader::download(url, destfile = paste0(out_dir, "/", slug, ".csv"))}
    } else {
      if(format == "shp") {downloader::download(url, destfile = paste0(out_dir, "\\", slug, ".zip"))}
      if(format == "kml") {downloader::download(url, destfile = paste0(out_dir, "\\", slug, ".kml"))}
      if(format == "csv") {downloader::download(url, destfile = paste0(out_dir, "\\", slug, ".csv"))}
    }},
    warning = function(w) {msg(w, "WARNING")},
    error = function(e) {msg(e, "ERROR")})

  return(TRUE)
}
