## Nested Forms

Simple forms create a single object when the form is submitted, e.g. reserving a table on Open Table creates a reservation object. In order to create multiple objects, we use nested forms. Nested forms allow us to create multiple objects in one go, and the user to only fill out one form.


### The Models

First create a model class for each object, e.g. registering students and creating a course schedule. In both classes we set the attributes on initialization, and define a self.all method which returns an array of all instances of that object.

```ruby
# student.rb
  class Student
    attr_reader :name, :grade

    STUDENTS = []

    def initialize(params)
      @name = params[:name]
      @grade = params[:grade]
      STUDENTS << self
    end

    def self.all
      STUDENTS
    end

  end

  # course.rb
  class Course
    attr_reader :name, :topic

    COURSES = []

    def initialize(args)
      @name = args[:name]
      @topic = args[:topic]
      COURSES << self
    end

    def self.all
      COURSES
    end
  end
```

### The Form

In this example both the student and course models have a name attribute. In a hash each key must be unique. In order to get around this we create a nested hash. We can use a 'name' attribute for both the student and model's since they exist in different name spaces.

```ruby
  # the required hash
  params = {
    "student" => {
      "name" => "Joe",
      "grade" => "9",
      "course" => {
        "name" => "US History",
        "topic" => "History"
      }
    }
  }
```

To create such a hash:

```ruby
  my_hash = {}
  my_hash["student"] = {}
  my_hash["student"]["name"] = "Joe"
  my_hash["student"]["grade"] = "9"
  my_hash["student"]["course"] = {}
  my_hash["student"]["course"]["name"] = "US History"
  my_hash["student"]["course"]["topic"] = "History"
```

ERB handles the first layer of nesting, so `my_hash['student']['name']` becomes `student["name"]`.


Our form becomes:

```html
  <form action="/student" method="post">
    Student Name: <input type="text" name="student[name]">
    Student Grade: <input type="text" name="student[grade]">
    Course Name: <input type="text" name="student[course][name]">
    Course Topic: <input type="text" name="student[course][topic]">
    <input type="submit" value="submit">
  </form>
```

Now we have the problem of dealing with two or more courses. To have two or more courses, we'll have a 'courses' key reference an array of 'course' hashes, e.g.

```ruby
  params = {
    "student" => {
      "name" => "Vic",
      "grade" => "12",
      "courses" => [
        {
          "name" => "AP US History",
          "topic" => "History"
        },
        {
          "name" => "AP Human Geography",
          "topic" => "History"
        }
      ]
    }
  }
```

Our form for such a hash would be:

```html
  <form action="/student" method="post">
    Student Name: <input type="text" name="student[name]">
    Student Grade: <input type="text" name="student[grade]">
    Course Name: <input type="text" name="student[courses][][name]">
    Course Topic: <input type="text" name="student[courses][][topic]">
    Course Name: <input type="text" name="student[courses][][name]">
    Course Topic: <input type="text" name="student[courses][][topic]">
    <input type="submit">
  </form>
```

In ruby if you wanted a hash to reference an array, you would do something like:

```ruby
  my_hash = {}
  my_hash["student"] = {}
  my_hash["student"]["name"] = "Joe"
  my_hash["student"]["courses"] = []
  my_hash["student"]["courses"][0] = { "name" => "AP US History", "topic" => "History"}
  my_hash["student"]["courses"][1] = { "name" => "AP Human Geography", "topic" => "History"}
```

To reference the individual hashes within the array:

```ruby
my_hash["student"]["courses"][0]["name"]
# => "AP US History"

my_hash["student"]["courses"][0]["topic"]
#  => "History"

my_hash["student"]["courses"][1]["name"]
# => "AP Human Geography"

my_hash["student"]["courses"][1]["topic"]
#  => "History"
```

With ERB you don't need to manually index each hash entry in the array, ERB can use an empty array, []. Thus, `my_hash["student"]["courses"][0]["name"]` becomes `student[courses][][name]`, as does `my_hash["student"]["courses"][1]["name"]`.


### The Display view

```html
  <h1>Student</h1>

  <div class="student">
    <h3>Name: <%= @student.name %></h3><br>
    <h4>Grade: <%= @student.grade %></h4>
  </div><br>

  <h1>Courses</h1>
  <% @courses.each do |course| %>
    <div class="course">
      <p>Name: <%= course.name %></p><br>
      <p>Topic: <%= course.topic %></p><br>
    </div><br>
  <% end %>
```

### The Controllers

```ruby
  # serve up the form in which we enter the data
  get '/' do
    erb :new
  end

  # process the data & render the erb template which will display the student and course details
  post '/student' do
    @student = Student.new(params[:student])

    params[:student][:courses].each do |details|
      Course.new(details)
    end

    @courses = Course.all

    erb :student
  end
```

In the first part of the controller action, we create a new Student using the info stored in params[:student], which contains the student's name, grade, and courses. We iterate over `params[:student][:courses]`, an array of hashes, creating an instance of a Course object for each hash. We can access the student and courses array via the `@student` and `@courses` instance variables respectively.
