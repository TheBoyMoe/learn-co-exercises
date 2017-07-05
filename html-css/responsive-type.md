# Responsive Type

## Overview

In this lesson we will look at strategies for making adjustments to type in responsive layouts.

## Objectives

1. Adjust text sizing to be responsive while maintaining its size relationship to other bodies of text.
2. Using column count to break text into columns across different screen sizes.

## Creating Responsive Type That's Easy To Maintain

<iframe width="640" height="480" src="//www.youtube.com/embed/I3SB9RNg74w?rel=0" frameborder="0" allowfullscreen></iframe>

*Note: Slides for this lecture video are provided in the resources at the bottom of this lesson.*

### Em, What Else Would I Use?

Using ems to size your typography site wide has one large advantage over pixels or percents. That is that this size measurement (em) is a relative measurement. Let's take a look at an example where we want our header text to always be two and a half times larger than our paragraph text. On certain devices when the screen gets below 400px we want all of our text to become 30% larger whilst still maintaining the relationship of the heading being 2.5 times larger than our paragraph.

```css
body { font-size: 100%; }
h1 { font-size: 2.5em; }
p { font-size: 1em; }

@media only screen and (max-width: 400px) {
  body { font-size: 130%; }  
} 
``` 

In the code above, on line 1, 2, and 3 we are setting default styles. The body element's default text size is already 100%, but we have included it here to clarify the change that's made in the media query. On line 2 we set all `h1` elements to be 2.5em, and on line 3 we set the `p` element to 1em. So, the h1 is two and a half times larger than our paragraphs. In our media query on line 5 we set the query to trigger for device screens less than 400 pixels. When this occurs on line 6 we adjust the body font-size to 130%. This causes all elements within the body (h1, p) to inherit this change and grow 30% larger. Since we sized using em, you'll notice that the h1 and p adjust in proportion to each other even as they grow or shrink in size. This makes it very convenient to make size adjustments to one element, the body and thus affect all other type in our layout uniformly.

### Column Count

Another simple tip for easily adjusting type is when you might want to wrap text into separate columns. This is especially true on larger screen sizes where you have big bodies of text content. You can imagine that as a paragraph stretches across bigger screens the sentences start to get really long, and it becomes awkward for the reader to find the next line after they reach the end and have to bring their eyes back across the screen and drop to exactly the next line of text. Designers suggest that for optimum readability you want the measure of your text lines to be between 40 to 80 characters. Anything smaller or larger becomes a bit awkward to read. To tackle this we can make use of a lesser known, yet fairly well supported CSS `column-count` property.

The default column-count is one, meaning text is contained within one column. When our screen gets bigger, it might be good to adjust the text into multiple columns; let's see an example:

```html
<article>
  <p>Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?</p>
</article>
```

```css
article p {
  column-count: 1; /* This is the default so we don't really need to specify */
}

@media only screen and (min-width: 480px) {
  article p {
    column-count: 2;  
  }
}
```

As we mentioned, paragraphs by default normally only occupy one column. However, we can create the visual effect of this single paragraph element splitting into multiple columns by setting our media query on line 5 to trigger on screens greater than 480px; then on line 7 we set our paragraph to adjust its column count to 2 columns instead. Have a look at this in the code example in the resource section below at the bottom of this lesson.

## Summary

- It is to our advantage to set all typography within our site to ems and then in media queries adjust the body font-size as a percent to adjust all type in proportion to each other. This greatly simplifies our media queries on typography.
- We can adjust the `column-count` property to split our text into virtual columns.

## Resources

- [Presentation Slides](https://docs.google.com/presentation/d/1j_i5pGPB5lHbgr4fpdUDheRBv2kAeOk_yhfd1Uc2f3s/edit?usp=sharing)
- [Responsive Type Sizing - Code Example](http://jsfiddle.net/flatiron_school/H6cN5/)
- [Responsive Type Column Count - Code Example](http://jsfiddle.net/flatiron_school/vy43K/2/)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/responsive-type' title='Responsive Type'>Responsive Type</a> on Learn.co and start learning to code for free.</p>
<p data-visibility='hidden'>View <a href='https://learn.co/lessons/responsive-type'>Responsive Type</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/responsive-type'>Responsive Type</a> on Learn.co and start learning to code for free.</p>