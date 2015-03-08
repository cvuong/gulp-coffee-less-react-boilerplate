CommentBox = require '../cjsx/CommentBox'
console.log 'testblah'

React.renderComponent CommentBox(),
  document.getElementById('content')
