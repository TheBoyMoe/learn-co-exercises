# SOLID

1. Singe Responsibility Principle
    * each class/module should focus on a single task
    * as a rule of thumb, when describing what a class does, if the description includes the word 'and', then it's generally doing too much and needs refactoring(You can treat the behaviour between the classes as their own classes).
    * By refactoring behaviours into separate modules/classes leads to de-coupling and allows those modules to be used by other apps.

2. Open/Closed Principle
    * the class, module, function, etc, should be open for EXTENSION, but closed for MODIFICATION.
    * you should build classes that may be extended via child classes so that the parent does not need to be changed.
    * any well written element should not have to be changed/re-written in order to add a new feature

3. Liskov Substitution Principle
    * replace any instance of a parent class with an instance of one of its child classes without negative side effects

4. Interface Segregation Principle
    * code should not be forced to depend on methods that it does not use

5. Dependency Inversion Principle
    * high level objects should not rely on low level implementations
    * a good example is the ActiveRecord class in Rails. It will let the user search a database, but does not implement the actual code. The actual implementation is by the child class which inherits ActiveRecord, allowing different database implemtations to be used.
    * it manages high-level functionality, no implementaion details, allowing the module to be used with any type of application.
