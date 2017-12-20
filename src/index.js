require('./styles/application.scss');

const digitalMarketingIpsum = require("digital-marketing-ipsum");

const Elm = require('./app/Main.elm');
const app = Elm.Main.embed(document.querySelector('#app'));

app.ports.changeIntro.subscribe(function(args) {
    //use args to call agency ipsum
    app.ports.ipsum.send(digitalMarketingIpsum.generateIpsum(args));
});
