Datastore = require 'nedb'
path = require 'path'
Photo = new Datastore
  filename: path.join __dirname, '../../photos.db'

module.exports = Photo