Photo = require('../models/Photo')
Photo.loadDatabase()

exports.list = (req, res) ->
  Photo.find {}, (err, docs) ->
    console.log JSON.stringify docs
    res.render 'list',
      photos: docs

exports.submit = (req, res, next) ->
  filename = req.files.photo.name
  Photo.insert
    filename: filename
  res.redirect '/'
