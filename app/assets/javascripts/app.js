App = new Object();
App.module = function(key, func) {
    App[key] = func;
};
App.module_name = document.body.getAttribute('data-controller') + '/' + document.body.getAttribute('data-action');
App.load_module = function () {
    var keys = App.module_name.split('/');
    var i = 0;
    var modules = [];
    var temp_key = '';

    for (i = 0; i < keys.length; i++) {
        temp_key += '/' + keys[i];
        modules.push(temp_key);
    }

    for (i = 0; i < modules.length; i++) {
        if (App.hasOwnProperty(modules[i])) App[modules[i]].call({module_name: modules[i]});
    }
};