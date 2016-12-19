#!/bin/bash
mkdir components/$1
cd  components/$1
touch $1.html
echo "import $ from \"../../vendor/jquery.min\";
import {Component} from \"../../vendor/noManure\";
require(\"./$1.css\")
var template = require(\"./$1.html\");
class $1 extends Component {
    constructor(){
        super(\"$1\");
        this.template = template;
    }
    render(){
        return super.render()
    }
    addListeners(){
    }
}
export var $1Component = new $1();
" > $1.js
touch $1.css