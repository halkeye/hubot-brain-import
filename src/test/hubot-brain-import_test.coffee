'use strict'

process.env.HUBOT_LOG_LEVEL="alert"
process.env.EXPRESS_PORT = process.env.PORT = 0

Hubot = require('hubot')
Path = require('path')
Url = require 'url'
Fs = require 'fs'
should = require('should')

adapterPath = Path.join Path.dirname(require.resolve 'hubot'), "src", "adapters"
{TextMessage} = require Path.join(adapterPath,'../message')

hubot_brain_import = require('../scripts/hubot-brain-import')

process.env.BRAIN_IMPORT_FILE = Path.resolve(__dirname +  '/../../brain-import.json')

describe 'Hubot-Brain-Import', ()->
  beforeEach ->
    @robot = Hubot.loadBot adapterPath, "shell", "true", "MochaHubot"
    hubot_brain_import(@robot)
    Fs.writeFileSync(process.env.BRAIN_IMPORT_FILE, JSON.stringify({}))

  afterEach ->
    Fs.unlinkSync(process.env.BRAIN_IMPORT_FILE, JSON.stringify({}))

  it 'handleError', ()->
    @robot.brain.emit('loaded')
