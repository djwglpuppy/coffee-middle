#Coffee-middle

An easy to use Connect / Express middleware node.js application for compiling coffee-script files.  

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

or Javascript (works in both)

```javascript
app.configure("development", function(){
	app.use(require("coffee-middle")({
        src: __dirname + "/precompiled/js",
        dest: __dirname + "/static/js"
    }));

    app.use(express.static(__dirname + '/static'));
    app.use(this.router);
});
```

##Parameters

- **src** (folder_dir) The folder directory where the `.coffee` files reside
<br /><i>(required)</i>

- **dest** (folder_dir) The folder directory where the `.js` files will reside
<br /><i>(required ONLY if you want to write the compiled coffee to a file)</i>

- **bare** (bool) A coffee compilation option to contain a function wrapper around the code within the file.  False means it will have the wrapper function, true means it will not. 
<br /><i>(defaults to **true**)</i>

- **jadeFunction** (string) The name of the Jade global helper function (described below)
<br /><i>(defaults to **coffee**)</i>

- **publicDir** (folder_dir) The name of the public directory that your script tags are referencing
<br /><i>(defaults to **/js**)</i>

- **writeFileToPublicDir** (bool) Write the compiled javascript file to the `dest` folder.  If you make it false, all compilation will be done on the fly.  If you do have file writing turned on, it will compile the file **only** if the coffee file is newer than the js file.
<br /><i>(defaults to **true**)</i>

- **minify** (bool) Minify the written outputted JS file using `uglify-js`
<br /><i>(defaults to **true**)</i>

##Jade Helper

You have a choice of explicitely telling Jade the coffee files (as javascript files), OR you can use the Jade Helper Function.

The Helper Function will look in the `src` folder you specified in the parameters and automatically tell Jade to ask for all the files in that directory.  This is especially helpful if you do not care about the order the files are created in.

###Manual

<i>(This is the normal jade way)</i>

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

<i>(This is using the helper function created from coffee-middle)</i>

```jade
!!!
html
	head
		title= title
		!= coffee()
```

If **orders.coffee, products.coffee, and customers.coffee** are in the `src` folder you specified, both of these implementations would output to html in the exact same way.


##The Future
...as you can see from the version number (0.0.1beta), I am just starting with this.  There are quite a bit of things I want to accomplish and will maark them shortly in the wiki.




