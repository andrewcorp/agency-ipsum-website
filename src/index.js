require('./styles/application.scss');

const Elm = require('./app/Main.elm');
const app = Elm.Main.embed(document.querySelector('#app'));
