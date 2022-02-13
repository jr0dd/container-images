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
	    '--remote-debugging-address=0.0.0.0'
    ]
  })
    .catch((error) => {
      console.log(error)
    })
})()
