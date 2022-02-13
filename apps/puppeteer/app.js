const puppeteer = require('puppeteer');

(async () => {
  await puppeteer.launch({
    headless: true,
    dumpio: true,
    args: [
    //   '--font-render-hinting=medium',
      '--disable-gpu',
      '--disable-dev-shm-usage',
      '--disable-setuid-sandbox',
      '--no-sandbox',
      '--remote-debugging-port=4000',
	    '--remote-debugging-address=0.0.0.0',
      '--user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36'
    ]
  })
    .catch((error) => {
      console.log(error)
    })
})()
