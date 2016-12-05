# Description:
#   Import brain data from a json file
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   halkeye

'use strict'
fs = require 'fs'

module.exports = (robot) ->
  robot.brain.once 'loaded', (data) ->
    file = process.env.BRAIN_IMPORT_FILE || process.cwd() + '/brain-import.json'
    robot.logger.debug "Looking for #{file}"
    fs.exists file, (exists) ->
      if !exists
        return
      robot.logger.debug "Brain import file (#{file}) exists. Importing."
      json = require file
      robot.brain.mergeData json
