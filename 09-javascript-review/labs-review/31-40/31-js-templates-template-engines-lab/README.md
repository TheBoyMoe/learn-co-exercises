# JavaScript Lodash Templates Lab

## Objectives

1. Practice using JavaScript templates for a simple blog
2. Practice modularizing code and templates
3. Practice separating view and logic concerns

## Introduction

In this lab, we're going to be using lodash templates to create a simple blog site with posts and comments. We want to use templates to modularize the page and dynamically load new elements.

Don't forget to run the tests and make sure everything works!

## Instructions

1. Create a template with an id of `page-template` that will represent the page of a blog post, including a `sidebar` element and a `post` element that will hold our blog post.
2. Create a `post-template` that will represent the blog post itself. It should have a `header` for the post title and a `footer` for the post author, and be wrapped in an `article` element.
3. Create a `comments-template` that will be the container for the collection of comments on the blog post, as well as the comment form.
4. Create a `comment-template` that will hold an individual comment. Should have a `footer` for the commenter name.
5. Provide a form with an id of `post-form` to create a blog post with a title, body, and author. Submitting the form should build the page template with the post inside. Make the form submit using a `createPost()` function.
6. Provide a form within the `comments-template` to post comments, including commenter name and comment text. These should use the template to insert individual comments into the comments section. You should be able to keep adding more comments. Make the form submit use a `postComment()` function.

## Resources

- [npm](https://npmjs.org)
