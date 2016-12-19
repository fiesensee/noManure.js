mkdir $1
echo "module.exports = {
    entry: './src/index.js',
    // entry: './src/testing.js',
    output: {
        path: __dirname + '/dist/js/',
        filename: 'bundle.js'
    },
    module: {
        loaders: [
            {test: /\.js$/, exclude: /node_modules/, loader: 'babel-loader'},
            {test: /\.html$/, loader: 'mustache'},
            {test: /\.css$/, loader: 'style-loader!css-loader'}
        ]
    },
    resolve: {
    extensions: ['', '.js'],
    }
}" > $1/webpack.config.js

echo "{
  \"name\": \"$1\",
  \"version\": \"1.0.0\",
  \"description\": \"\",
  \"main\": \"dist/main.js\",
  \"scripts\": {
      \"compile\": \"webpack\"
  },
  \"author\": \"\",
  \"license\": \"\",
  \"devDependencies\": {
    \"babel-core\": \"^6.18.2\",
    \"babel-loader\": \"^6.2.7\",
    \"babel-preset-es2015\": \"^6.18.0\",
    \"css-loader\": \"^0.25.0\",
    \"extract-text-webpack-plugin\": \"^1.0.1\",
    \"mustache-loader\": \"^0.4.0\",
    \"style-loader\": \"^0.13.1\",
    \"webpack\": \"^1.13.3\"
  }
}" > $1/package.json

echo "{
  \"presets\": [\"es2015\"]
}" > $1/.babelrc

echo "{
    \"env\": {
        \"browser\": true,
        \"commonjs\": true,
        \"es6\": true,
        \"node\": true
    },
    \"parserOptions\": {
        \"ecmaFeatures\": {
            \"jsx\": true
        },
        \"sourceType\": \"module\"
    },
    \"rules\": {
        \"no-const-assign\": \"warn\",
        \"no-this-before-super\": \"warn\",
        \"no-undef\": \"warn\",
        \"no-unreachable\": \"warn\",
        \"no-unused-vars\": \"warn\",
        \"constructor-super\": \"warn\",
        \"valid-typeof\": \"warn\"
    }
}" > $1/.eslintrc.json

echo "node_modules/
dist/" > $1/.gitignore

mkdir $1/components

mkdir $1/vendor

echo "import $ from \"./jquery.min\";

export class Component {
    constructor(name){
        this.appInstance = null;
        this.name = name;
        this.data = null;
        this.props = null;
    };
    render(){
        console.log(\"rendering\");
        return new Promise((resolve) => resolve(this.template(this.data)))
    }
    addListeners(){};  
}

export class App {
    constructor(ElementID){
        this.AppElement = $(\"#\" + ElementID);
        this.components = [];
        this.props = {};
    }
    registerComponent(component){
        this.components.push(component);
    }
    renderComponent(componentName, props={}){
        var component = this.components.find(comp => {
            return comp.name == componentName;
        });
        component.props = props;
        component.appInstance = this;
        component.render().then((out) => {
            this.AppElement.html(out);
            component.addListeners();
        })
    };
}" > $1/vendor/noManure.js



cd $1 && npm install

echo "Created new Project"