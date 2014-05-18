eco = require "eco"
fs  = require "fs"

Home = require './controllers/home'
Games = require './controllers/games'
Settings = require './controllers/settings'

Spine.Controller.prototype.view = (path, data) ->
  template = fs.readFileSync __dirname + "/views/#{path}.eco", "utf-8"
  eco.render template, data

class App extends Spine.Stack
  className: 'stack root'

  controllers:
    home: Home
    games: Games
    settings: Settings

  default: 'home'

  activeController: ->
    for controller in @manager.controllers
      if controller.isActive()
        return controller
        break

  showHome: ->
    @home.active()

  showSettings: ->
    @settings.active()

  showGames: (gameConsole) ->
    @games.gameConsole = gameConsole
    @games.update()
    @games.active()

  keydown: (e) ->
    @activeController().keyboardNav(e)

module.exports = App
