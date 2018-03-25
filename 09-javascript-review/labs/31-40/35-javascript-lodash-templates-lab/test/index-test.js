describe('index', () => {
  describe('post form', () => {
    it('exists and submits correctly', () => {
      var postForm = document.getElementById("post-form");
      expect(postForm).toExist("Must have a form with an id of post-form");
      expect(postForm).toMatch(/onsubmit="createPost()/, "Form must submit to a createPost() function");
    })
  })

  describe('functions', () => {
    before(() => {
      window._ = require('lodash')
    })

    describe('createPost', () => {
      it('exists', () => {
        expect(createPost).toExist("Must have a function named createPost")
      })
      it('builds the proper templates', () => {
        var spy = expect.spyOn(window._, 'template').andCallThrough()
        createPost()
        expect(spy).toHaveBeenCalledWith(document.getElementById("page-template").innerHTML)
        expect(spy).toHaveBeenCalledWith(document.getElementById("post-template").innerHTML)
      })
    })

    describe('postComment', () => {
      it('exists', () => {
        expect(postComment).toExist("Must define a function named postComment")
      })
      it('builds the proper templates', () => {
        createPost()
        var spy = expect.spyOn(window._, 'template').andReturn(function(){})
        postComment()
        expect(spy).toHaveBeenCalledWith(document.getElementById("comment-template").innerHTML)
      })
    })
  })

  describe('templates', () => {
    it('has a comments template', () => {
      var commentsTemplate = document.getElementById("comments-template");
      expect(commentsTemplate).toExist("Must have a lodash template with an id of 'comments-template'");
      expect(commentsTemplate.type).toBe("text/x-lodash-template", "Must be of type text/x-lodash-template");
      expect(commentsTemplate.innerHTML).toMatch(/div id="comments"/, "Template must have a div with an id of 'comments'");
      expect(commentsTemplate.innerHTML).toMatch(/form onsubmit="postComment()/, "Template must include a form to post comments");
    })
    it('has a comment template', () => {
      var commentTemplate = document.getElementById("comment-template");
      expect(commentTemplate).toExist("Must have a lodash template with an id of 'comment-template'");
      expect(commentTemplate.type).toBe("text/x-lodash-template", "Must be of type text/x-lodash-template");
      expect(commentTemplate.innerHTML).toMatch(/footer/, "Template must have a <footer> element");
    })
    it('has a page template', () => {
      var pageTemplate = document.getElementById("page-template");
      expect(pageTemplate).toExist("Must have a lodash template with an id of 'page-template'");
      expect(pageTemplate.type).toBe("text/x-lodash-template", "Must be of type text/x-lodash-template");
      expect(pageTemplate.innerHTML).toMatch(/div id="sidebar"/, "Template must have a div with an id of 'sidebar'");
      expect(pageTemplate.innerHTML).toMatch(/div id="post"/, "Template must have a div with an id of 'post'");
    })
    it('has a post template', () => {
      var postTemplate = document.getElementById("post-template");
      expect(postTemplate).toExist("Must have a lodash template with an id of 'post-template'");
      expect(postTemplate.type).toBe("text/x-lodash-template", "Must be of type text/x-lodash-template");
      expect(postTemplate.innerHTML).toMatch(/footer/, "Template must have a <footer> element");
      expect(postTemplate.innerHTML).toMatch(/header/, "Template must have a <header> element");
      expect(postTemplate.innerHTML).toMatch(/article/, "Template must have an <article> element");
    })
  })
})
