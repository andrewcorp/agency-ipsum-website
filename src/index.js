require('./styles/application.scss');

const digitalMarketingIpsum = require("digital-marketing-ipsum");

const Elm = require('./app/Main.elm');
const app = Elm.Main.embed(document.querySelector('#app'));

const ipsum = (args) => digitalMarketingIpsum.generateIpsum(args) + '.';

app.ports.generateIntro.subscribe((args) => app.ports.newIntro.send(ipsum(args)));
app.ports.generateIpsum.subscribe((args) => app.ports.newIpsum.send(ipsum(args)));
