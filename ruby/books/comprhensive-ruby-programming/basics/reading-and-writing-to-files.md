## File Handling

 * You can create, read, write, delete and append to files with the 'File' class.

### Create a file

```Ruby
  File.open("./bacon-ipsum.txt" , 'w+') { |f| f.write("Shoulder t-bone sausage, pig jowl frankfurter short ribs ham hock landjaeger turducken filet mignon tail pancetta venison.") }
```

 * To create a file, call the .open class method passing it two parameters
    * the 1st is the path to the file
    * the 2nd are the options, e.g read, write, append, read & write, etc.
      * 'r' - read
      * 'a' - append
      * 'w' - write
      * 'w+' - read and write
      * 'a+' - read and append
      * 'r+' - read, write and append
 * in the code block we're passing to the file object the string of values to be written, calling the #write method.

You could accomplish the same task using the following code:

```Ruby
  file_to_save = File.new("./bacon-ipsum.txt" , 'w+')
  file_to_save.puts("Shoulder t-bone sausage, pig jowl frankfurter short ribs ham hock landjaeger turducken filet mignon tail pancetta venison.")
  file_to_save.close
```        

### Read a file

```Ruby
  str = File.read("./bacon-ipsum.txt")
```

The read method returns a string


### Delete a file

```Ruby
  File.delete("./bacon-ipsum.txt")
```


### Append to a file

```Ruby
  File.open("./bacon-ipsum.txt", 'a') {|f| f.puts "More bacon for dinner, with a bottle of bud!"}
```
