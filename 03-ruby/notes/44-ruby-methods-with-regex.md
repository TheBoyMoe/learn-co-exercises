
# Ruby Methods with Regex

## Objectives

- Use the `match` method
- Use capture groups
- Use the `scan` method
- Understand the diff between `match` and `scan`


## Ruby Methods with Regex

You've learned the basics of writing Regular Expressions in Ruby. In this lesson we'll learn how to use regular expressions with the `match` and `scan` ruby methods. We'll also learn to use capture groups.


### Scan
The `scan` method returns an array of **all** items in your string that match a given Regular Expression. For example:

```
"The rain in Spain lies mainly in the plain".scan(/\w+ain/)
=> ["rain", "Spain", "main", "plain"]
```

### Match
The `match` method returns the first item in your string that matches a given Regular Expression as a `MatchData` object. For example:
```
"The rain in Spain lies mainly in the plain".match(/\w+ain/)
=> #<MatchData "rain"> 

"The rain in Spain lies mainly in the plain".match(/France/)
=> nil
```
More often than not, we use the result of the match method as a boolean, indicating the existence of the pattern in the given string.

### Grep

Grep is an enumerable method for pattern searching in arrays and hashes. Similar to `scan`, `grep` will return an array of matching items from an array.

```ruby
names = ["Jeri Faria", "Althea Voth", "Audry Donoho", "Scotty Chaves", "Lance Barrio", "Zachary Newhall", "Stefany Janey", "Tressie Kinsel", "Raven Grimsley", "Marketta Gaylor", "Leota Crowe", "Mazie Norman", "Damien Loffredo"]

#Get items from array where first name has five letters:
names.grep(/^\w{5}\s/)

=> ["Audry Donoho", "Lance Barrio", "Raven Grimsley", "Leota Crowe", "Mazie Norman"]

```

### Capture Groups
Using parentheses in our regex allows us to create 'groups' that we can refer to in our scan/match/grep methods as indexes in an array. In the example below we create three capture groups for the three sets of digits in a phone number. Now, when we scan a list of numbers, each phone number is broken down into subgroups based on the capture groups we built in our regular expressions:

```
numbers = "202-555-0192 202-555-0147 202-555-0131 202-555-0116 202-555-0192 202-555-0197"

number_breakdown = numbers.scan(/(\d+)-(\d+)-(\d+)/)
=> [["202", "555", "0192"], ["202", "555", "0147"], ["202", "555", "0131"], ["202", "555", "0116"], ["202", "555", "0192"], ["202", "555", "0197"]] 

number_breakdown[0]
=> ["202", "555", "0192"]

number_breakdown[0][1]
=> "555"

```
