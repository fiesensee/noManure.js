module.exports = {
    entry: "./src/index.js",
    // entry: "./src/testing.js",
    output: {
        path: __dirname + "/dist/js/",
        filename: "bundle.js"
    },
    module: {
        loaders: [
            {test: /\.js$/, exclude: /node_modules/, loader: "babel-loader"},
            {test: /\.html$/, loader: "mustache"},
            {test: /\.css$/, loader: "style-loader!css-loader"}
        ]
    },
    resolve: {
    extensions: ['', '.js'],
    }
}