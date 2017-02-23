// window.setTimeout(() => (alert(`HAMMERTIME`)), 5000)
//
// const hammerTime = (time) => {
//   window.setTimeout(() => (alert(`${time} is hammertime!`)), time)
// }

const readline = require('readline');

const reader = readline.createInterface(
  {
    input: process.stdin,
    output: process.stdout
  }
);

reader.question('Would you like some tea?', (res) => {
    const firstRes = (res === 'yes') ? 'do' : 'don\'t';
    console.log(`You replied ${res}.`);

    reader.question('Would you like some biscuits?', (res) => {
        const secondRes = (res === 'yes') ? 'do' : 'don\'t';
        console.log(`You replied ${res}.`);
        console.log(`So you ${firstRes} want tea and you ${secondRes} want biscuits.`);
        reader.close();
    });
});
