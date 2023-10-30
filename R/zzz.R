#' @import V8
#'
eng <- NULL
.onLoad <- function(libname, pkgname) {

  eng <<- V8::v8()

  all_files <- list.files(
    system.file(package = "jsfns")
  )

  js_files <- subset(all_files, all_files %in% grep("\\.js",all_files,value=TRUE))

  sapply(js_files, function(x) { eng[["source"]](system.file(x, package="jsfns"))})

}
