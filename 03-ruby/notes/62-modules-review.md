## Modules

You can think of a module as a toolbox that contains a set methods and constants. There are lots and lots of Ruby tools you might want to use, but it would clutter the interpreter to keep them around all the time. For that reason, we keep a bunch of them in modules and only pull in those module toolboxes when we need the constants and methods inside!

You can think of modules as being very much like classes, only modules can't create instances and can't have subclasses. They're just used to store things!


```ruby
  module Circle

    PI = 3.141592653589793

    def Circle.area(radius)
      PI * radius**2
    end

    def Circle.circumference(radius)
      2 * PI * radius
    end
  end
```

Modules are defined using the `module` keyword, with the names written in CamelCase.

```ruby
  module ModuleName
    # .....

  end  
```

It doesn't make sense to include variables in modules, since variables (by definition) change (or vary). Constants, however, are supposed to always stay the same.

Ruby doesn't make you keep the same value for a constant once it's initialized, but it will warn you if you try to change it. Ruby constants are written in ALL_CAPS and are separated with underscores if there's more than one word.

One of the main purposes of modules is to separate methods and constants into named spaces. This is called (conveniently enough) namespacing, and it's how Ruby doesn't confuse Math::PI and Circle::PI - avoiding name collisions. The `::` is the 'scope resolution operator'. To call the PI version in Math:

```ruby
  puts Math::PI
```

While some modules, like Math, are already present in the interpreter. Others need to be explicitly brought in, we can do this using `require keyword`

```ruby
  require 'date'
  # imports the Date module

  date = Date.now
```  

We can also `include` a module. A class that includes a module can use that modules methods. This means that we do not have to prepend a modules constants and methods with the module name.

```ruby
  class Angle
    include Math

    attr_accessor :radians

    def initialize(radians)
      @radians = radians
    end

    def cosine
      cos(@radians)
      # instead of writing Math::cos()
    end
  end

  acute = Angle.new(1)
  acute.cosine
```
