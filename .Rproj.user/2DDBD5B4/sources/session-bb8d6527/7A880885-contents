# jsfns

Inspired by Josiah Parry's [pyfns](https://github.com/JosiahParry/pyfns/tree/main) package which illustrates a minimal approach to exporting Python functions in R package. This package serves to illustrate a minimal approach to exporting Javascript functions by use of the [V8 package](https://cran.r-project.org/web/packages/V8/index.html). 

Alot of the text in this README here is copied from Josiah's and adjusted to fit the context of this package. Thank you Josiah for doing much of the heavy lifting!

The process consists of: 

1. Having the package source the `.js` scripts on start-up.

2. Create R wrappers for the Javascript functions. 

Example Usage:

```r
> # Calling a function that doesn't accept any arguments
> jsfns::hello_world()
Hello World!
> # Calling a function which accepts an argument
> jsfns::hello_name("Ben")
Hello Ben!
```


# Storing Javascript Scripts

Store javascript scripts inside of `inst/`. These files can be read using `system.file()`. `inst/helloWorld.js` contains:

```js
function helloWorld(){
  console.log("Hello World!");
}
```

`inst/helloName.js` contains: 

```js
function helloName(name) {
  print("Hello " + name + "!");
}

```

# Sourcing scripts

Scripts are sourced in `R/zzz.R` in which there is an `.onLoad()` function call. This gets called only once when the package is loaded.

```r
eng <- NULL
.onLoad <- function(libname, pkgname) {

  eng <<- V8::v8()

  all_files <- list.files(
    system.file(package = "jsfns")
  )

  js_files <- subset(all_files, all_files %in% grep("\\.js",all_files,value=TRUE))

  sapply(js_files, function(x) { eng[["source"]](system.file(x, package="jsfns"))})

}

```

In this chunk identify all the `.js` files located in `inst` and use the `source` method from `V8::v8()` to bring the javascript functions into scope. The function needs a path to the javascript code that we want to source. This is where `system.file()` comes into play. It can access files stored in `inst`. Note that it does not include `inst`. 

# Wrapper Functions

Since the functions are sourced into the environment on start-up, they can be called from the environment directly. If there were arguments we can pass them in using `...` in the outer function or recreating the same function arguments.

As such the code for `hello_world()` is: 


```r
hello_world <- function() {
  eng[["call"]]("helloWorld")
}

```

And for `hello_name()`:

```r

hello_name <- function(name){
  eng[["call"]]("helloName",name)
}

```
