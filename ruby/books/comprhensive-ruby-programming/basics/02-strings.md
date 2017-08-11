## Strings & Numbers

### Strings

1. String interpolation - the process of dynamically integrating values into a String.
    - the string must be enclosed within double quotes, and the variables appear within '#{}'

```Ruby
  p "The quick brown #{animal} jumped over the lazy #{noun}"
```

2. Methods with similar names, the only difference being a bang! at the end - the ! version changes the original value stored in the variable.

3. #sub vs #gsub - #sub replaces the first match found in a string, #gsub replaces all matches(global substitution)

4. #strip vs #chomp - #chomp strips white space chars from the ends osf a string, #strip removes them from the front and end of a string
