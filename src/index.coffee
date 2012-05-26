_ = require("underscore")
fs = require("fs")
coffee = require("coffee-script")
uglify = require("uglify-js")

module.exports = (config = {}) ->
    _.defaults config,
        src: ""
        dest: ""
        bare: true
        helperScope: global
        jadeFunction: "coffee"
        publicDir: "/js"
        writeFileToPublicDir: true
        minify: false
        browserReload: false
        browserReloadPort: 11911

    if config.minify
        pro = uglify.uglify
        jsp = uglify.parser

    throw "The src parameter for coffee-middle needs to be filled out" if config.src is ""

    config.src += "/" if config.src.substr(-1) isnt "/"
    config.dest += "/" if config.dest.substr(-1) isnt "/"
    config.publicDir += "/" if config.publicDir.substr(-1) isnt "/"

    fileListing = {}
    coffeefiles = fs.readdirSync(config.src)

    #Create a Listing of valid coffee files
    _.each coffeefiles, (file) ->
        valid = file.match /(.*).coffee$/i
        if valid?
            fileListing[valid[1]] =
                coffee: config.src + valid[1] + ".coffee"
                js: config.dest + valid[1] + ".js"
                public: config.publicDir + valid[1] + ".js"

    #socket.io reloader
    if config.browserReload
        io = require("socket.io").listen(config.browserReloadPort)
        io.set('log level', 1)

        _.each coffeefiles, (file) ->
            fs.watch config.src + file, (e) ->
                io.sockets.emit("updatecoffee", {change: true}) if e is "change"





    #Global Jade Helper
    config.helperScope[config.jadeFunction] = (rendertype = "both") ->
        display = ""
        if rendertype in ["files", "both"]
            display += _.map(fileListing, (file) -> "<script src='#{file.public}'></script>").join("\r")

        if (rendertype in ["reload", "both"]) and config.browserReload
            display += "<script src='http://localhost:#{config.browserReloadPort}/socket.io/socket.io.js'></script>"
            display += """<script>
                var socket = io.connect('http://localhost:#{config.browserReloadPort}');
                socket.on('updatecoffee', function (data) {
                    if (data.change === true){
                        window.location.reload(true);
                    }
                });
            </script>"""


    return (req, res, next) ->
        return next() if req.method isnt "GET"


        iscoffeefile = req.path.match new RegExp(config.publicDir + "(.*)\.js$")
        if iscoffeefile?
            info = fileListing[iscoffeefile[1]]
            return next() if not info?

            cf = fs.statSync(info.coffee).mtime
            try
                jf = fs.statSync(info.js).mtime
            catch badfileerror
                jf = 0

            if cf > jf
                coffeecode = fs.readFileSync info.coffee, "ascii"
                content = coffee.compile(coffeecode, {bare: config.bare})
                res.contentType("application/javascript")
                res.send(content)

                if config.writeFileToPublicDir

                    if config.minify
                        ast = jsp.parse(content)
                        pro.ast_mangle(ast)
                        ast = pro.ast_squeeze(ast)
                        content = pro.gen_code(ast)
                
                    fs.writeFileSync(info.js, content) if config.writeFileToPublicDir

            else
                next()
        else
            next()