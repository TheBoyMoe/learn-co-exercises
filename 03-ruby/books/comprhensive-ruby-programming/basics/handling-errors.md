## Handling errors

1. Using rescue
  - use a begin/rescue block to capture errors
  - instead of displaying the error message,  the code within the 'rescue' block is executed
  - any code following begin/rescue block will be executed, i.e. the app continues on and does not crash due to the error.

```Ruby
  begin
    puts 8/0
  rescue
    puts 'Rescued the error'
  end
```

2. The current block above will catch every error that occurs. You can be more specific by specifying the specific error type, e.g ZeroDivisionError, only that specific error will be caught. Any other type of error will be thrown as normal. This particular type of will print a specific error message that will give you a better idea of what occurred.

```Ruby
  begin   
    puts 8/0
  rescue ZeroDivisionError => e   
    puts "Error occurred: #{e}"
  end
```
To catch more generic errors look for standard errors

```Ruby
begin   
  puts 8/0
rescue StandardError => e   
  puts "Error occurred: #{e}"
end
```

### logging errors in a production app

Create a method called #error_logger which will be responsible for appending all errors that occur to a log file

```Ruby
  def error_logger(e)   
    File.open('./error_log.txt', 'a') do |file|
      file.puts e   
    end
  end
```

In the actual program code, use a begin/rescue block where ever an error could potentially be thrown.

```Ruby
  begin   
    # code that could throw an error
  rescue StandardError => e   
    error_logger("Error: #{e} at #{Time.now}")
  end
```
