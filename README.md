[![build status](https://secure.travis-ci.org/djwglpuppy/coffee-middle.png)](http://travis-ci.org/djwglpuppy/coffee-middle)
#Coffee-middle

A Connect / Express middleware node.js application for compiling coffee-script files to a new file or on the fly.

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

##Automatic Browser Reload

This is an experimental feature utilizing [socket.io](https://github.com/LearnBoost/socket.io) while using **Jade** templates. It will automatically reload your browser (currently working with chrome) on changes and update the latest coffee file.) 

In order to utilize this workflow feature:

- Set the `browserReload` parameter to `true`
- Add the helper global method to your **Jade Template** (currently only works in jade)
- Make sure that you ignore the directory containing your client CoffeeScript files if you are using a service like [supervisor](https://github.com/isaacs/node-supervisor)

Usage (express.js configuration)

```coffeescript
#Recommended only for development mode!!!
app.configure "development", ->
	app.use(require("coffee-middle")({
        src: __dirname + "/precompiled/js",
        dest: __dirname + "/static/js",
        browserReload: true
    }));

```

Usage (Jade Template File) *(just include the global function mentioned below)*

```jade
!!!
html
	head
		title= title
		!= coffee()
```


##Parameters

- **src** (folder_dir) : The folder directory where the `.coffee` files reside
<br /><i>(required)</i>

- **dest** (folder_dir) : The folder directory where the `.js` files will reside
<br /><i>(required ONLY if you want to write the compiled coffee to a file)</i>

- **bare** (bool) : A coffee compilation option to contain a function wrapper around the code within the file.  False means it will have the wrapper function, true means it will not. 
<br /><i>(defaults to **true**)</i>

- **jadeFunction** (string) : The name of the Jade global helper function (described below)
<br /><i>(defaults to **coffee**)</i>

- **publicDir** (folder_dir) : The name of the public directory that your script tags are referencing
<br /><i>(defaults to **/js**)</i>

- **writeFileToPublicDir** (bool) : Write the compiled javascript file to the `dest` folder.  If you make it false, all compilation will be done on the fly.  If you do have file writing turned on, it will compile the file **only** if the coffee file is newer than the js file.
<br /><i>(defaults to **true**)</i>

- **minify** (bool) : Minify the written outputted JS file using `uglify-js`
<br /><i>(defaults to **true**)</i>

- **browserReload** (bool) : Tells the application to listen for changes to your coffee files and automatically reload your browser.
<br />*(defaults to **false**)  …this is an experimental feature and recommended only for development mode and not for production*

- **broserReloadPort** (number) : The port for the socket.io instance to listen on if `browserReload is set to TRUE
<br />*(defaults to 11911)*

##Jade Helper

You have a choice of explicitely telling Jade the coffee files (as javascript files), OR you can use the Jade Helper Function.

The Helper Function will look in the `src` folder you specified in the parameters and automatically tell Jade to ask for all the files in that directory.  This is especially helpful if you do not care about the order the files are created in.

The helper can have an optional passed in argument with one of the following values:

- **files** *(default if `browserReload` param is set to FALSE)* : only output the source of the files
- **reload** : add in the Javascript so that automatic browserReload will work
- **both** *(default if `browserReload` param is set to TRUE)* : Do both operations above

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

*(This is using the helper function created from coffee-middle)*

```jade
!!!
html
	head
		title= title
		!= coffee()
```

*(optional argument passed in)*

```jade
!!!
html
	head
		title= title
		!= coffee("both")
```


If **orders.coffee, products.coffee, and customers.coffee** are in the `src` folder you specified, both of these implementations would output to html in the exact same way.


##The Future
...as you can see from the version number (0.0.2), I am just starting with this.  There are quite a bit of things I want to accomplish and will mark them shortly in the wiki.




