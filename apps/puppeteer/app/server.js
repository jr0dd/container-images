const puppeteer = require('puppeteer')

const args = process.argv.slice(2)

const defaultArgs = [
  // required docker flags
  '--disable-dev-shm-usage',
  '--disable-setuid-sandbox',
  '--no-sandbox',
  // websocket config
  '--remote-debugging-address=0.0.0.0',
  '--remote-debugging-port=4000'
]

args.forEach(arg => {
  defaultArgs.push(arg)
});

(async () => {
  await puppeteer.launch({
    headless: true,
    dumpio: true,
    args: defaultArgs
  })
    .catch((error) => {
      console.log(error)
    })
})()
