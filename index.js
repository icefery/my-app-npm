const http = require('http')
const https = require('https')
const fs = require('fs')
const path = require('path')
const express = require('express')

const app = express()

app.get('/*', (req, res) => res.json({ url: `${req.protocol}://${req.get('host')}${req.originalUrl}` }))

const httpPort = 8080
http.createServer(app).listen(httpPort, () => console.log(`Listening on :${httpPort}`))

const httpsPort = 8443
const options = {
  key: fs.readFileSync(path.join(__dirname, './certs/domain.key')),
  cert: fs.readFileSync(path.join(__dirname, './certs/domain.crt'))
}
https.createServer(options, app).listen(httpsPort, () => console.log(`Listening on :${httpsPort}`))
