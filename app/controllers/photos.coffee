Photo = require('../models/Photo')
# Load Database into memory
Photo.loadDatabase()

exports.list = (req, res) ->
  Photo.find {}
    .sort
      created: -1
    .exec (err, docs) ->
      # console.log JSON.stringify docs
      res.render 'list',
        photos: docs

exports.submit = (req, res, next) ->
  filename = req.files.photo.name
  Photo.insert
    filename: filename
    created: new Date()
  res.redirect '/'
