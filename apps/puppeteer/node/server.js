const puppeteer = require('puppeteer')

const args = process.argv.slice(2)

const defaultArgs = [
  '--user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS  X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/ 85.0.4183.121 Safari/537.36',
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
    .catch((err) => {
      console.error(err)
    })
})()
