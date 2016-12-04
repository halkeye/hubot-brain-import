'use strict'

process.env.HUBOT_LOG_LEVEL="alert"
process.env.EXPRESS_PORT = process.env.PORT = 0

mockFS = require('mock-fs')
Hubot = require('hubot')
Path = require('path')
Url = require 'url'
should = require('should')

adapterPath = Path.join Path.dirname(require.resolve 'hubot'), "src", "adapters"
{TextMessage} = require Path.join(adapterPath,'../message')

hubot_brain_import = require('../scripts/hubot-brain-import')

mockFiles = {}
mockFiles[Path.resolve(__dirname + '/../../node_modules/hubot/package.json')] = JSON.stringify({
  "version": "0.1.2"
})
mockFiles[Path.resolve(__dirname +  '/../../brain-import.json')] = JSON.stringify({})


describe 'Hubot-Brain-Import', ()->
  beforeEach ->
    @robot = Hubot.loadBot adapterPath, "shell", "true", "MochaHubot"
    mockFS(mockFiles)
    hubot_brain_import(@robot)

  afterEach ->
    mockFS.restore()

  it 'handleError', ()->
    @robot.brain.emit('loaded')
