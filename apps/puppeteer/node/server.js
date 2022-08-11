import puppeteer from 'puppeteer'
import chalk from 'chalk'

(async () => {
  const defaultArgs = [
    '--disable-dev-shm-usage',
    '--disable-setuid-sandbox',
    '--no-sandbox',
    '--disable-audio-output',
    '--disable-gpu',
    '--no-zygote',
    '--disable-software-rasterizer',
    '--disable-features=IsolateOrigins,site-per-process',
    '--disable-site-isolation-trials',
    '--disable-web-security',
    '--single-process',
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
