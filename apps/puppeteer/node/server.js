import puppeteer from 'puppeteer'
import chalk from 'chalk'

(async () => {
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
  const args = process.argv.slice(2)
  args.forEach(arg => {
    defaultArgs.push(arg)
  })

  await puppeteer.launch({
    headless: true,
    dumpio: true,
    ignoreHTTPSErrors: true,
    args: defaultArgs
  })
    .catch((err) => {
      console.error(chalk.redBright(err))
    })

  console.log(chalk.magentaBright('<== Puppeteer server is running ==>'))
})()
