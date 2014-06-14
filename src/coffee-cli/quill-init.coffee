$ ()->
  htmlInput = $('#htmlContent')
  advancedEditor = new Quill('#editor',
    modules:
      'toolbar': { container: '#toolbar' }
      'link-tooltip': true
      'image-tooltip': true
    theme: 'snow'
  )

  advancedEditor.on('text-change', (delta, source) ->
    console.info 'advanced', 'text', delta, source
    return if source == 'api'

    console.log advancedEditor.getHTML()
    console.log advancedEditor.getContents()
    htmlInput.val advancedEditor.getHTML()
  )