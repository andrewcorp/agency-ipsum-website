require('./styles/application.scss');

const digitalMarketingIpsum = require("digital-marketing-ipsum");

const Elm = require('./app/Main.elm');
const app = Elm.Main.embed(document.querySelector('#app'));

app.ports.generateIntro.subscribe(function(args) {
    //use args to call agency ipsum
    app.ports.newIntro.send(digitalMarketingIpsum.generateIpsum(args));
});

app.ports.generateIpsum.subscribe(function(args) {
    //use args to call agency ipsum
    app.ports.newIpsum.send(digitalMarketingIpsum.generateIpsum(args));
});
