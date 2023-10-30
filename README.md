# jsfns

Inspired by Josiah Parry's [pyfns](https://github.com/JosiahParry/pyfns/tree/main) package which illustrates a minimal approach to exporting Python functions in R package. This package serves to illustrate a minimal approach to exporting Javascript functions by use of the [V8 package](https://cran.r-project.org/web/packages/V8/index.html).

By nature of V8 being unable to save instances for the future, this package follow's the guidelines for package development with V8. 

> A V8 context cannot be saved or duplicated, but creating a new context and sourcing code is very cheap. You can run as many parallel v8 contexts as you want. R packages that use V8 can use a separate V8 context for each object or function call.

As such there is no new environment, nor any use of an `.onLoad()` function. In this illustration, each individual function creates a new V8 instance every time the function is called.

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

# Wrapper Functions

Unlike the elegant solution that `pyfns` provides, making use of javascript code with `V8` requires the creation of a new context and sourcing of code every time the function is called. 

As such the code for `hello_world()` is: 


```r
hello_world <- function() {
  eng <- V8::v8("jsfns")
  eng[["source"]](
    system.file("helloWorld.js",package="jsfns")
  )
  eng[["call"]]("helloWorld")
}

```

And for `hello_name()`:

```r

hello_name <- function(name){

  eng <- V8::v8("jsfns")
  eng[["source"]](
    system.file("helloName.js",package="jsfns")
  )
  eng[["call"]]("helloName",name)
}

```
