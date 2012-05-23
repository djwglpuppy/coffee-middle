#Coffee-middle

A simple to use connect / express middleware application for compiling coffee-script files.  

##Installation

```
npm install coffee-middle
```

##Usage

```
app = express.createServer(
    express.bodyParser(),
    express.cookieParser()
)

app.configure ->
    @set('views', __dirname + '/views')
    @set('view engine', 'jade')


app.configure "development", ->

	#Here I am!
    @use(require("coffee-middle")({
        src: __dirname + "/precompiled/js/"
        dest: __dirname + "/static/js/"
    }))

    @use(express.static(__dirname + '/static'))
    @use(this.router)


```

###Optional Parameters

- **src** (folder_dir) The folder directory where the `.coffee` files reside
<i>(required)</i>

- **dest** (folder_dir) The folder directory where the `.js` files will reside
<i>(required ONLY if you want to write the compiled coffee to a file)</i>

- **bare** (bool) A coffee compilation option to contain a function wrapper around the code within the file
<i>(defaults to false)</i>

- **stylusFunction** (string) The name of the stylus global function (described below)
<i>(defaults to `coffee`)</i>

- **publicDir** (folder_dir) The name of the public directory that your script tags are referencing
<i>(defaults to `/js/` (for now make sure to put a trailing slash))</i>

- **writeFileToPublicDir** (bool) Write the compiled javascript file to the `dest` folder
<i>(defaults to `true`)</i>

- **minify** (bool) Minify the written outputted JS file using `uglify-js`
<i>(defaults to true)</i>
