const puppeteer = require('puppeteer');

(async () => {
  await puppeteer.launch({
    headless: true,
    dumpio: true,
    args: [
      // required docker flags
      '--disable-dev-shm-usage',
      '--disable-gpu',
      '--disable-setuid-sandbox',
      '--no-sandbox',
      // cors handling
      '--disable-features=IsolateOrigins,site-per-process',
      '--disable-site-isolation-trials',
      '--disable-web-security',
      // websocket config
      '--remote-debugging-address=0.0.0.0',
      '--remote-debugging-port=4000',
      '--user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36'
    ]
  })
    .catch((error) => {
      console.log(error)
    })
})()
