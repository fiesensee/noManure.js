import $ from "./jquery.min";

export class Component {
    constructor(name){
        this.appInstance = null;
        this.name = name;
        this.data = null;
        this.props = null;
    };
    render(){
        console.log("rendering");
        return new Promise((resolve) => resolve(this.template(this.data)))
    }
    addListeners(){};  
}

export class App {
    constructor(ElementID){
        this.AppElement = $("#" + ElementID);
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
}
