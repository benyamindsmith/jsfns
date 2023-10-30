#' Hello <Name> - A Javascript to R example (accepting args this time)
#'
#' @export
hello_name <- function(name){

  eng <- V8::v8("jsfns")
  eng[["source"]](
    system.file("helloName.js",package="jsfns")
  )
  eng[["call"]]("helloName",name)
}
