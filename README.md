#Coffee-middle

A simple to use connect / express middleware application for compiling coffee-script files.  

##Installation

```
npm install coffee-middle
```

##Usage

```coffeescript
app.configure "development", ->
	app.use(require("coffee-middle")({
        src: __dirname + "/precompiled/js/"
        dest: __dirname + "/static/js/"
    }))

    app.use(express.static(__dirname + '/static'))
    app.use(this.router)
```

###Optional Parameters

- **src** (folder_dir) The folder directory where the `.coffee` files reside
<br /><i>(required)</i>

- **dest** (folder_dir) The folder directory where the `.js` files will reside
<br /><i>(required ONLY if you want to write the compiled coffee to a file)</i>

- **bare** (bool) A coffee compilation option to contain a function wrapper around the code within the file
<br /><i>(defaults to **false**)</i>

- **stylusFunction** (string) The name of the stylus global function (described below)
<br /><i>(defaults to **coffee**)</i>

- **publicDir** (folder_dir) The name of the public directory that your script tags are referencing
<br /><i>(defaults to **/js** (for now make sure to put a trailing slash))</i>

- **writeFileToPublicDir** (bool) Write the compiled javascript file to the `dest` folder
<br /><i>(defaults to **true**)</i>

- **minify** (bool) Minify the written outputted JS file using `uglify-js`
<br /><i>(defaults to **true**)</i>