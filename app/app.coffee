express = require 'express'
jade = require 'jade'
path = require 'path'
multer = require 'multer'

app = express()

app.set 'view engine', 'jade'
app.set 'views', path.join __dirname, 'view'
app.locals.pretty = 'true'

# Public folder
app.use multer
  dest: path.join __dirname, '../photos'
app.use(express.static(path.join(__dirname, '../build')))
app.use(express.static(path.join(__dirname, '../photos')))

app.locals.devMode = true

photos = require './controllers/photos'
app.route('/')
  .get photos.list
  .post photos.submit

app.listen(4040)