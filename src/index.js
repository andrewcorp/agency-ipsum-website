require('./styles/application.scss');

const digitalMarketingIpsum = require("digital-marketing-ipsum");

const Elm = require('./app/Main.elm');
const app = Elm.Main.embed(document.querySelector('#app'));

const ipsum = (args) => digitalMarketingIpsum.generateIpsum(args) + '.';
const copyToClipboard = () => {
  let tmpInput = document.createElement('input'),
      toCopy = document.getElementById("ipsum-text").innerText;
  document.body.appendChild(tmpInput)
  tmpInput.value = toCopy;
  tmpInput.select();
  document.execCommand("Copy");
  tmpInput.remove();
}


app.ports.generateIntro.subscribe((args) => app.ports.newIntro.send(ipsum(args)));
app.ports.generateIpsum.subscribe((args) => app.ports.newIpsum.send(ipsum(args)));
app.ports.copyText.subscribe(() => copyToClipboard());
