## Variables and Scope

1. Scope defines where in an application a variable is visible and so accessible.

2. In ruby you have global, local, class and instance scope.
    - Global scope is the whole application,
    - Local scope is limited to the loop, method, or do-end block
    - Class scope is shared amongst all instances of a class, i.e. a class variable is visible to all instances of that particular class.
    - Instance scope is limited to that particular instance of the class

3. When ever you create a class, module or define a method you're creating a new scope, variables outside that scope are NOT accessible.
    - a do-end block creates local scope, variables defined within it are not visible outside, but the block has access to variables defined outside of it.  

3. Local variables are limited to the scope in which they are created
    - limited to the method, loop or do-end block created in
    - name begins with lower case a-z or _ (underscore)

4. Global variables are visible throughout the whole application
    - name begins with '$'

5. Class variables are visible throughout ALL instances of the class.
    - name begins with '@@'

6. Instance variables are limited to that instance
    - name begins with '@'  

7. Constants once assigned a value, should not be changed
    - names should be in all uppercase [A-Z]
    - unlike other languages you can change constants, takes the last value assigned
    - constants are assigned global scope unless declared within a class or module



References:
1. [Ruby, scope and variables](https://www.sitepoint.com/understanding-scope-in-ruby/)    
