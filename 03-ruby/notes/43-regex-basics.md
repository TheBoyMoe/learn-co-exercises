# RegEx Basics

## Objectives

- Use the range [a-z] as well as the specific character [abc] matchers
- interpolate required letter with the ranges/patterns. /[hH]ello/
- Use backslash special characters like \w
- Use backslash as escape
- Use star, dot, and plus
- Use rubular.com


## Introduction

In this lesson, we're going to learn the syntax and basic vocabulary of regular expressions. We'll start simple and build from there. A great place to head for RegEx testing and practice is [Rubular](http://rubular.com/) - it allows you to build and test regular expressions against text that you define. In a separate window, open up Rubular. In the text box entitled "Your Test String", paste in the following monologue from Shakespeare's *The Merchant of Venice*:

>If to do were as easy as to know what were good to do, chapels had been churches and poor men's cottages princes' palaces. It is a good divine that follows his own instructions: I can easier teach twenty what were good to be done, than be one of the twenty to follow mine own teaching. The brain may devise laws for the blood, but a hot temper leaps o'er a cold decree: such a hare is madness the youth, to skip o'er the meshes of good counsel the cripple. But this reasoning is not in the fashion to choose me a husband. O me, the word 'choose!' I may neither choose whom I would nor refuse whom I dislike; so is the will of a living daughter curbed by the will of a dead father. Is it not hard, Nerissa, that I cannot choose one nor refuse none?

We've set this up in [Rubular for you here](http://rubular.com/r/s2jizA9W9V). Your window should look like this:
![rubular setup](http://curriculum-content.s3.amazonaws.com/web-development/Regex/rubular_setup.png)


## Writing Regular Expressions

In Ruby, regular expressions are generally written between forward slashes: `/your regex/`. This is the 'literal' alternative to creating a regular expression object using the following syntax: `Regexp.new('your regex')`. In Rubular, you can see that these slashes have already been written for you.

### Simple Text Matching

Let's start with the simplest text matching. Add the following RegEx in rubular:
```
/twenty/
```

![twenty regex](https://curriculum-content.s3.amazonaws.com/web-development/Regex/twenty.png)

Notice that the pattern matches the two instances of "twenty" in the passage. Writing a series of letters or numbers in your regular expression will result in a search for exact matches of this pattern anywhere in the string. 

### Metacharacters
The real beauty of regular expressions is revealed in its use of metacharacters. Metacharacters allow you to use a pre-defined shorthand to match specific characters. For example, `\d` will match any digit in your text, and `\w` will match any word character (letters, numbers, and underscores). The 'RegEx Quick Reference' at the bottom of Rubular shows metacharacters and patterns that you can use. Play around with these a little. Use `\W` (notice uppercasing) to match the non-word characters in your text.

### Only specific characters

If I want to match all instances of vowels in a string, the RegEx `/aeiou/` won't work (feel free to try it), as it will only match the entire string "aeiou" - which clearly isn't in our text. Instead let's use square brackets: `/[aeiou]/` - this is looking for only **one single** character in our text which matches any of the characters inside the square brackets. If you add this RegEx to our rubular, you'll see every vowel highlighted in your match result.

### Ranges

Based on what we've just learned, we can write a regular expression looking for single characters in the first 10 letters of the alphabet like so:`/[abcdefghij]/`
We can actually shorten this in Ruby using a RegEx range:`/[a-j]/`

`[0123456789]` becomes `[0-9]`

### Example: Double Vowels

There are many other metacharacters and ways of building patterns in RegEx, many of which you can refer in the Rubular quick reference guide. However, the best way to actually learn to use regular expressions is to practice building your own patterns. Let's look for instances in our text of two consecutive vowels (for example, 'ae', 'ie', 'oo', etc). The longest way to do this is to hand code the different combinations of two vowels:`/aa|oo|ee|ii|uu|ae|ea|ou|ie|ei|eo|oe/`. It's pretty tedious to hand code each of these combinations (I didn't finish). An improvement is to use two sets of square brackets with vowels, each one representing a single character: `/[aeiou][aeiou]/`. Our most efficient, however, is to use repetitions: `/[aeiou]{2}/` The curly braces surrounding mean that the pattern or character directly preceding it must repeat that number of times. As such, we're looking for a repeat of a vowel two times. As you can see, there are many ways to write a regular expression that does the same thing. 

## Resources

+ [Rubular](http://rubular.com/)
+ [RegEx One](http://regexone.com/)
+ [RegEx Golf](http://regex.alf.nu/)
+ [RegExr](http://www.regexr.com/)

 