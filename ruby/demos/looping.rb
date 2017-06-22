# looping examples

# loop
counter = 0
loop do
    counter += 1
    puts "#{counter}. iterations of the loop"
    if counter >= 10
        break
    end
end

# while loop
while counter < 20
    puts "#{counter} looping using while"
    counter += 1
end

#until loop
until counter == 30
    puts "#{counter} looping using until"
    counter += 1
end

#do while loop (or you can use until)
begin
    puts "#{counter} using a do while loop"
    counter += 1
end while counter < 40

# each loop
array = [1,2,3,4,5,6,7,8]
array.each do |value|
    puts "#{value * 2} using each loop"
end    

# each loop with an index
X.each_with_index do |item, index|
  puts "current_index: #{index}"
end


# execute a loop a set number of times
10.times do
    puts "#{counter} using times loop"
    counter += 1
end    


# nested arrays
scores = [
  [34,65,87,35,56,76,67,87,67],
  [45,67,46,98,67,54,76,45,76],
  [65,76,56,87,88,76,56,76,64]
]

str = "Individual scores: "
scores.each do |subject|
    subject.each do |score|
       str += score.to_s + " "     
    end    
end
puts str.strip