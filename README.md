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
        src: __dirname + "/precompiled/js"
        dest: __dirname + "/static/js"
    }))

    app.use(express.static(__dirname + '/static'))
    app.use(this.router)
```

##Parameters

- **src** (folder_dir) The folder directory where the `.coffee` files reside
<br /><i>(required)</i>

- **dest** (folder_dir) The folder directory where the `.js` files will reside
<br /><i>(required ONLY if you want to write the compiled coffee to a file)</i>

- **bare** (bool) A coffee compilation option to contain a function wrapper around the code within the file
<br /><i>(defaults to **true**)</i>

- **jadeFunction** (string) The name of the Jade global helper function (described below)
<br /><i>(defaults to **coffee**)</i>

- **publicDir** (folder_dir) The name of the public directory that your script tags are referencing
<br /><i>(defaults to **/js**)</i>

- **writeFileToPublicDir** (bool) Write the compiled javascript file to the `dest` folder
<br /><i>(defaults to **true**)</i>

- **minify** (bool) Minify the written outputted JS file using `uglify-js`
<br /><i>(defaults to **true**)</i>

##Jade Helper

You have a choice of explicitely telling Jade the coffee files (as javascript files), OR you can use the Jade Helper Function.

The Helper Function will look in the `src` folder you specified in the parameters and automatically tell Jade to output those files for you.  This is especially helpful if you do not care about the order the files are created in.

###Manual
<br /><i>(This is the normal jade way)</i>

```jade
!!!
html
    head
        title= title
        script(src='/js/orders.js')
        script(src='/js/products.js')
      	script(src='/js/customers.js')
```

###Helper Function
<br /><i>(This is using the helper function created from coffee-middle)</i>

```jade
!!!
html
	head
		title= title
		!= coffee()
```

##The Future
...as you can see from the version number (0.0.1beta), I am just starting with this.  There are quite a bit of things I want to accomplish and will make them shortly in the wiki.




