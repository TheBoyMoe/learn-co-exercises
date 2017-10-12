# HTML5 Semantic Elements

## Overview

In this lesson we will learn about semantic elements, their purpose, and best practices for using them.

## Objectives

1. Historical significance and why semantic elements were created.
2. Familiarization with HTML5 Semantic Elements.
 
## A Better Way To Markup Content

<iframe width="640" height="480" src="//www.youtube.com/embed/V28xLFEYaSQ?rel=0&modestbranding=1" frameborder="0" allowfullscreen></iframe>

*Note: Slides for this lecture video are provided in the resources at the bottom of this lesson.*

### A Brief History

At the dawn of HTML, developers had but one common element that was used to create generic boxes and that my friend was the `<div>` element. Pages layouts at that time then became a sea of divs. This worked, but we needed a way to label them to distinguish one div from another. This was largely done with id and class names such as 

```html
<div id="header">
  <div class="wrapper">...</div>
</div>
```

When the W3C (the organization that oversees the spec for HTML & CSS) started writing the spec for HTML5 they wanted to create new elements that would eliminate the need to label so many divs and make our code more readable for developers and more descriptive to browsers. Along with the help of Google hundreds of thousands of websites were scanned and all the most common id and class names were recorded. It turned out that many developers were in fact using the same names to label their elements. Such as `id="header"` or `"footer"`, `"main"`, `"nav"`, `"section"`, `"article"`, `"aside"`, etc. For each of these most common labels we now have elements we can use instead. So instead of

```html
<div id="header">...</div>
```

we can use

```html
<header></header>
```

The one thing all semantic elements have in common is that we should use them when the content within the element has related meaning.

> se·man·tic
> səˈman(t)ik/
> adjective
>    relating to meaning in language or logic.

To clarify, all of the content in the `<header>` is relating to introductory content or containing navigational aids, just like the head of a document. Let's take a div layout and convert it using semantic elements instead

```html
<div class="wrapper">
  <div id="header">
     <div id="nav">...</div>
  </div>
  <div id="main">
    <div id="music">
      <div id="rock">...</div>
      <div id="jazz">...</div>
    </div>
  </div>
  <div id="aside">...</div>
  <div id="footer">...</div>
</div>
```

Now we'll convert it using HTML5 Semantic Elements

```html
<div class="wrapper">
  <header>
     <nav>...</nav>
  </header>
  <main>
    <section id="music">
      <article id="rock">...</article>
      <article id="jazz">...</article>
    </section>
  </main>
  <aside>...</aside>
  <footer>...</footer>
</div>
```

Notice that in cases where the content within the element is not semantically related or we have the need to simply create a generic box such as the `wrapper`, we can still use divs as we please.

### Some Semantic Elements Worth Knowing

Next let's talk about the semantic meaning intended for each element so you have an idea of how they were meant to be used. As a developer there are no hard rules of how to configure these elements. We only have their intended meaning to work off of, so you should feel comfortable configuring them in a way that makes the most sense to you and best suits your layout needs. The following descriptions are as they are stated from Mozilla Developer Networks documentation.

#### Article

`<article>...</article>`

The HTML `<article>` element represents a self-contained composition in a document, page, application, or site, which is intended to be independently distributable or reusable (e.g., in syndication). This could be a forum post, a magazine or newspaper article, a blog entry, an object, or any other independent item of content. Each `<article>` should be identified, typically by including a heading (`<h1>-<h6>` element) as a child of the `<article>` element.

#### Aside

`<aside>...</aside>`

The HTML `<aside>` element represents a section of the page with content connected tangentially to the rest, which could be considered separate from that content. These sections are often represented as sidebars or inserts. They often contain the definitions on the sidebars, such as definitions from the glossary; there may also be other types of information, such as related advertisements; the biography of the author; web applications; profile information or related links on the blog.

#### Details

`<details>..</details>`

The HTML Details Element (`<details>`) is used as a disclosure widget from which the user can retrieve additional information.

#### Figure & Figcaption

`<figure>...<figcaption>...</figcaption></figure>`

The HTML `<figure>` element represents self-contained content, frequently with a caption (`<figcaption>`), and is typically referenced as a single unit. While it is related to the main flow, its position is independent of the main flow. Usually this is an image, an illustration, a diagram, a code snippet, or a schema that is referenced in the main text, but that can be moved to another page or to an appendix without affecting the main flow.

The HTML `<figcaption>` element represents a caption or a legend associated with a figure or an illustration described by the rest of the data of the `<figure>` element which is its immediate ancestor which means `<figcaption>` can be the first or last element inside a `<figure>` block. Also, the HTML Figcaption Element is optional; if not provided, then the parent figure element will have no caption.

#### Footer

`<footer>...</footer>`

The HTML `<footer>` element represents a footer for its nearest sectioning content or sectioning root element. A footer typically contains information about the author of the section, copyright data or links to related documents.

#### Header

`<header>...</header>`

The HTML `<header>` element represents a group of introductory or navigational aids. It may contain some heading elements but also other elements like a logo, wrapped section's header, a search form, and so on.

#### Main

`<main>...</main>`

The HTML `<main>` element represents the main content of  the `<body>` of a document or application. The main content area consists of content that is directly related to, or expands upon the central topic of a document or the central functionality of an application. This content should be unique to the document, excluding any content that is repeated across a set of documents such as sidebars, navigation links, copyright information, site logos, and search forms (unless the document's main function is as a search form).

#### Mark

`<mark>...</mark>`

The HTML Mark Element (`<mark>`) represents highlighted text, i.e., a run of text marked for reference purpose, due to its relevance in a particular context. For example it can be used in a page showing search results to highlight every instance of the searched-for word.

#### Nav

`<nav>...</nav>`

The HTML `<nav>` element (HTML Navigation Element) represents a section of a page that links to other pages or to parts within the page: a section with navigation links.

#### Section

`<section>...</section>`

The HTML `<section>` element represents a generic section of a document, i.e., a thematic grouping of content, typically with a heading. Each `<section>`should be identified, typically by including a heading (`<h1>-<h6>` element) as a child of the `<section>` element.

#### Time

`<time>`

The HTML `<time>` element represents either a time on a 24-hour clock or a precise date in the Gregorian calendar (with optional time and timezone information).

This element is intended to be used presenting dates and times in a machine readable format. This can be helpful for user agents to offer any event scheduling for user's calendar.

### Older Browser Support

Support for semantic elements is easily achieved in older browsers by linking to both `modernizr.js` and `normalize.css` or an equivalent CSS reset file that tells all the semantic elements to display block. As time moves on this is less and less neccesary as older browsers are used less and less.

## Summary

- If the content within an element is all semantically related it is a best practice to use the appropriate HTML5 semantic element if one applies.
- You can still use divs to create generic boxes or grouping elements as needed.
- We can provide support for newer elements by linking to both `modernizr.js` and `normalize.css`.

## Resources

- [Presentation Slides](https://docs.google.com/presentation/d/1tl0aB0EUOhLMi1Xr19UCAUTCY20FRqEDv-oDGg2cTkg/edit?usp=sharing)
- [Dive into HTML5 - Semantic Elements](http://diveintohtml5.info/semantics.html#new-elements)
- [MDN - HTML - Element Reference](https://developer.mozilla.org/en-US/docs/Web/HTML/Element)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/HTML5-Semantic-Elements' title='HTML5 Semantic Elements'>HTML5 Semantic Elements</a> on Learn.co and start learning to code for free.</p>

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/HTML5-Semantic-Elements'>HTML5 Semantic Elements</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/HTML5-Semantic-Elements'>HTML5 Semantic Elements</a> on Learn.co and start learning to code for free.</p>