#' Hello World - A Javascript to R Example
#'
#' @export
hello_world <- function() {
  eng <- V8::v8("jsfns")
  eng[["source"]](
    system.file("helloWorld.js",package="jsfns")
  )
  eng[["call"]]("helloWorld")
}
