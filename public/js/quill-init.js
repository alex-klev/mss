(function() {
  $(function() {
    var advancedEditor, htmlInput;
    htmlInput = $('#htmlContent');
    advancedEditor = new Quill('#editor', {
      modules: {
        'toolbar': {
          container: '#toolbar'
        },
        'link-tooltip': true,
        'image-tooltip': true
      },
      theme: 'snow'
    });
    return advancedEditor.on('text-change', function(delta, source) {
      console.info('advanced', 'text', delta, source);
      if (source === 'api') {
        return;
      }
      console.log(advancedEditor.getHTML());
      console.log(advancedEditor.getContents());
      return htmlInput.val(advancedEditor.getHTML());
    });
  });

}).call(this);

/*
//# sourceMappingURL=quill-init.js.map
*/
