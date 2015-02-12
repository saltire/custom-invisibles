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

  observeChar: (char) ->
    # set character from editor settings
    @subEditorChar = atom.config.observe 'editor.invisibles.' + char, (value) ->
      if value isnt ' ' then atom.config.set 'custom-invisibles.' + char + 'Char', value
      atom.config.set 'custom-invisibles.' + char + 'Active', value isnt ' '

    # show/hide character
    @subCheck = atom.config.observe 'custom-invisibles.' + char + 'Active', (active) ->
      value = atom.config.get 'custom-invisibles.' + char + 'Char'
      atom.config.set 'editor.invisibles.' + char, if active then value else ' '

    # set custom character
    @subChar = atom.config.observe 'custom-invisibles.' + char + 'Char', (value) ->
      if atom.config.get 'custom-invisibles.' + char + 'Active'
        atom.config.set 'editor.invisibles.' + char, value

  activate: ->
    chars = ['cr', 'eol', 'space', 'tab']
    @observeChar(char) for char in chars

  deactivate: ->
    @subCheck.dispose
    @subChar.dispose
    @subEditorChar.dispose
