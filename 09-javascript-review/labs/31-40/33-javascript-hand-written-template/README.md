JavaScript Hand-Written Templates
---

## Objectives

1. Work with the web as strings
2. Modularize changes to the DOM on a larger scale
3. Encapsulate changes to the DOM as functions

## Introduction

In a lot of ways, building applications for the web boils down to manipulating the DOM of a page to change the look and data that we show to a user.

That's really it. Whether we're waiting for our bank accounts to update on Mint or following a trending topic on Twitter, the part that's visible to users, and arguably the most important part, is the stuff that loads new and updated information into the browser window.

In this lesson, we're going to walk through using JavaScript to dynamically add comments to a blog post.

## Manually Updating Comments

Let's take a look at the provided `index.html` for our blog:

```html
<body>
  <article>
    <header><h2>The Results are In!</h2></header>
    <p>
      After careful consideration and a generous grant from NASA, our team has determined that a woodchuck could chuck five wood, with a standard deviation of +/- .37 wood.
    </p>
    <footer>posted by Chuck Wooden</footer>
  </article>
</body>
```

Inside each `<article>` tag is a blog post (about some very important scientific research) with a `<header>` and `<footer>`. We want to add some comments, so let's start by doing it the old-fashioned way. Add a new `<div>` to the first blog post, within the article, under the footer, and include a paragraph with your comments.

```html
<article>
  <header><h2>The Results are In!</h2></header>
  <p>
    After careful consideration and a generous grant from NASA, our team has determined that a woodchuck could chuck five wood, with a standard deviation of +/- .37 wood.
  </p>
  <footer>posted by Chuck Wooden</footer>
  <div><p>This checks out.</p></div>
</article>
```

Okay, we did it. Let's add another paragraph for the commenter's name, since we forgot that. Make it a child of the comment `div`.

```html
<div>
   <p>This checks out.</p>
   <p>posted by: Woodrow P Chuckington</p>
</div>
```

Great! Now we have another comment, so let's go ahead and get back in that HTML and add it.

![Frustrated_Jordan](https://user-images.githubusercontent.com/17556281/28326809-c759f4fe-6baf-11e7-9602-02ec4b9cb897.gif)

Yeah, just kidding. I'm not going to make you do that. Editing comments directly in the HTML is obviously unsustainable, for a lot of reasons, not the least of which is that were *definitely* not giving every visitor to our blog the ability to directly edit our HTML, but also, we have better things to do with our lives. We have at least a dozen episodes of the Bachelorette to catch up on, we don't have time for this.

Let's make JavaScript do the work for us.

### Dynamically Updating Comments With JavaScript

We can use JavaScript to update all this HTML and save time. First, let's add a place in our blog post to put comments by creating a `div` with an `id` of "comments":

```html
<article>
  <header><h2>The Results are In!</h2></header>
  <p>
    After careful consideration and a generous grant from NASA, our team has determined that a woodchuck could chuck five wood, with a standard deviation of +/- .37 wood.
  </p>
  <footer>posted by Chuck Wooden</footer>
  <div id="comments">
  </div>
</article>
```

Now we'll write a script and utilize `innerHTML` to update our comments, wiring it all up with a link to click:

```html
<body>
  <article>
    <header><h2>The Results are In!</h2></header>
    <p>
      After careful consideration and a generous grant from NASA, our team has determined that a woodchuck could chuck five wood, with a standard deviation of +/- .37 wood.
    </p>
    <footer>posted by Chuck Wooden</footer>
    <a href="#" onclick="addComment();">Add Comment</a>
    <div id="comments">
    </div>
  </article>
  <script type="text/javascript" charset="utf-8">
    function addComment() {
      var commentDiv = document.getElementById('comments');
      commentDiv.innerHTML = '<div><p>This research is bold and important!</p><p>I wish to join your team</p></div><div><p>posted by: <span>I swear I am not a woodchuck</span></p></div>';
    }
  </script>
</body>
```

That works, but it was kind of a lot to manually keep track of all the HTML *markup* in a single string with all of the comment *data*. Generally, we want to separate those concerns.

### Creating a Template

Beyond the obvious reasons of "this is ugly and hard to type", if we keep putting comments in this way, manually putting in the HTML with every new string, we're bound to mess it up eventually. What we need is a way to reliably reproduce the structure, and give it the data and allow it to build the comment for us.

What we are trying to do is create a *template* for comments that we can reuse for every new comment. A template defines the HTML and provides places to insert data dynamically.

We need a way to separate the creation of the markup structure from the process of collecting and inserting new data. To achieve that, let's break this up into some other functions and modularize it so that we can control it a little better.

It looks like we have a couple of things we have to do for every comment:

1. Create a `div` to hold the comment text.
2. Create a `div` to hold the commenter name with a "posted by:" text.
3. Add it all to the post's main comments `div`.

Let's implement these, and move them all into our `index.js` file as
well to keep things clean and tidy.

```js
// index.js

function addComment() {
  var bodyText = "This research is bold and important!";
  var commenter = "Definitely not a woodchuck looking to eat the wood";

  var commentBody = createCommentBody(bodyText);
  var commenterLabel = createCommenterLabel(commenter);
  postNewComment(commentBody, commenterLabel);
}

function createCommentBody(comment) {
  var bodyDiv = document.createElement("div");
  var bodyPara = document.createElement("p");
  bodyPara.innerHTML = comment;
  bodyDiv.appendChild(bodyPara);
  return bodyDiv;
}

function createCommenterLabel(commenter) {
  var commenterDiv = document.createElement("div");
  var commenterLabel = document.createElement("p");
  commenterLabel.innerHTML = "posted by:&nbsp;";
  var commenterName = document.createElement("span");
  commenterName.innerHTML = commenter;
  commenterLabel.appendChild(commenterName);
  commenterDiv.appendChild(commenterLabel);
  return commenterLabel;
}

function postNewComment(body, commenter) {
  var commentsDiv = document.getElementById("comments");
  var newCommentDiv = document.createElement("div");
  newCommentDiv.appendChild(body);
  newCommentDiv.appendChild(commenter);
  commentsDiv.appendChild(newCommentDiv);
}
```

Now that we've broken it up into these four functions, we can pass any comment text and commenter to them and build out a fully-formed, well-formatted comment `div` without having to worry about hand creating the tags every time.

We also now have the ability to modify the structure of the HTML we use for comments, say, adding new elements or CSS classes, without affecting how we collect and insert the data of the comments themselves.

We have just created a *template* for comments with these functions. It's not the friendliest-looking set of functions, but it does everything a template should do: it defines the structure of the markup, it takes discrete data elements and plugs them into the markup, and it takes the resulting markup and data and inserts it into the DOM.

We broke each function up along the lines of each section of the DOM we wish to manipulate, affording us the ability to more easily manage the structure of our comments in a more modular and composable way, rather than trying to do everything in one function which isn't that much of an improvement over just typing all the markup into a string.

Templates are all about being able to dynamically modify the DOM in repeatable, composable chunks that are easy to manage, maintain, and change.

### Dynamic Data Collection

Just to really nail it home, let's make this truly dynamic by adding a comment form.

In the `index.html`, we will get rid of our "Add Comment" link and create a form using the same function.

```html
<!-- ... -->
<footer>posted by Chuck Wooden</footer>
<form id="newComment" onSubmit="addComment()">
  Add comment: <input type="text" id="commentText"><br>
  Your name: <input type="text" id="commenterName"><br>
  <input type="submit">
</form>
<div id="comments">
</div>
```

And augment our `addComment` function to take the values from the form. We shouldn't need to change any other JavaScript code if we set up our template functions correctly.

```js
function addComment() {
  event.preventDefault();
  var bodyText = document.getElementById("commentText").value;
  var commenter = document.getElementById("commenterName").value;

  var commentBody = createCommentBody(bodyText);
  var commenterLabel = createCommenterLabel(commenter);
  postNewComment(commentBody, commenterLabel);
}
```

We added a line to the top of this function `event.preventDefault()`. We'll explain more about `event`s later, but for now all you need to know is that this line prevent the default action of a form, which would be submitting and reloading the page. Since we don't want to reload the page and we're writting some JavaScript to take care of the form submission, we prevent the default action.

Let's reload `index.html` and try out our new comment form. If we did everything right, we should now be able to dynamically add comments to this blog post, and we all know the internet needed one more place where people can add comments.

![someone wrong](http://imgs.xkcd.com/comics/duty_calls.png)

## Summary

We've walked through creating a very basic template for a blog comments section, starting with the problematic and unsustainable practice of editing HTML directly and ending with a nicely modular way of collecting comment data and displaying it on our blog post in a predictable, repeatable way.

## Resources

- [MDN: innerHTML](https://developer.mozilla.org/en-US/docs/Web/API/Element/innerHTML)
- [MDN: appendChild](https://developer.mozilla.org/en-US/docs/Web/API/Node/appendChild)
- [MDN: createElement](https://developer.mozilla.org/en-US/docs/Web/API/Document/createElement)

<p class='util--hide'>View <a href='https://learn.co/lessons/javascript-hand-written-templates'>Javascript Hand Written Templates</a> on Learn.co and start learning to code for free.</p>
