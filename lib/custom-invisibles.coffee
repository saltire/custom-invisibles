{CompositeDisposable} = require 'atom'

module.exports =
  config:
    crActive:
      title: 'Show carriage returns'
      type: 'boolean'
      default: true
    crChar:
      title: 'Carriage return character'
      type: ['boolean', 'string']
      default: '\u00a4'
    eolActive:
      title: 'Show line breaks'
      type: 'boolean'
      default: true
    eolChar:
      title: 'Line break character'
      type: ['boolean', 'string']
      default: '\u00ac'
    spaceActive:
      title: 'Show leading spaces'
      type: 'boolean'
      default: true
    spaceChar:
      title: 'Leading space character'
      type: ['boolean', 'string']
      default: '\u00b7'
    tabActive:
      title: 'Show tabs'
      type: 'boolean'
      default: true
    tabChar:
      title: 'Tab character'
      type: ['boolean', 'string']
      default: '\u00bb'

  setChar: (char) ->
    atom.config.set('editor.invisibles.' + char,
      if atom.config.get('custom-invisibles.' + char + 'Active')
      then atom.config.get('custom-invisibles.' + char + 'Char')
      else '')

  observeChar: (char) ->
    atom.config.observe 'custom-invisibles.' + char + 'Active', => @setChar(char)
    atom.config.observe 'custom-invisibles.' + char + 'Char', => @setChar(char)

  activate: ->
    @observeChar(char) for char in ['cr', 'eol', 'space', 'tab']
