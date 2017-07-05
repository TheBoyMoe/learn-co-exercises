# Responsive Media

## Overview

In this lesson we will look at a strategy for making our media content reponsive.

## Objectives

1. Adjust media sizing to be responsive.

## Adjusting Media For Responsive Layouts

<iframe width="640" height="480" src="//www.youtube.com/embed/iC2yQbR_qys?rel=0&modestbranding=1" frameborder="0" allowfullscreen></iframe>

*Note: Slides for this lecture video are provided in the resources at the bottom of this lesson.*

### Be Like Water!

> “You must be shapeless, formless, like water. When you pour water in a cup, it becomes the cup. When you pour water in a bottle, it becomes the bottle. When you pour water in a teapot, it becomes the teapot. Water can drip and it can crash. Become like water my friend.”
> -Bruce Lee

Using percent (%) measurements on our media allows them to fluidly fill the size of their container. In most cases our media is contained within the columns and rows of our layouts.

```css
img, form, input, table, video, audio, iframe {
  width: 100%;
  max-width: 100%;
}
```

Here we set our images, forms, inputs, tables, videos, audio elements, and i frames all to expand `width: 100%;` setting them to be as wide as the parent they are inside of. Then using `max-width: 100%;` prevents them from getting any larger than their parent. Using both these properties will insure that they scale fluidly in all browsers. Having them fill their columns allows us to write fewer media queries overall as they will squish and expand until we set a fixed size for their parent elements.

## Summary

- We can set our media to `width: 100%; max-width: 100%;` to give them flexible fluid widths that will expand to the size of their parent. This allows us to write fewer media queries as they will resize to accomodate the device automatically in most cases.

## Resources

- [Presentation Slides](https://docs.google.com/presentation/d/1j_i5pGPB5lHbgr4fpdUDheRBv2kAeOk_yhfd1Uc2f3s/edit?usp=sharing)
- [Responsive Media Content - Code Example](http://jsfiddle.net/flatiron_school/HP6A3/1/)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/responsive-media' title='Responsive Media'>Responsive Media</a> on Learn.co and start learning to code for free.</p>