## Rails

### Overview
Rails follows convention over configuration:
 * database tables have standardised names  
 * html templates are stored in standardised folders  
 * app code is stored in a standardised architecture, one of the patterns followed is MVC

### MVC Pattern
One of the conventions Rails follows is a pattern that's widely used in software development, called "Model, View, Controller", or MVC.

 * The models write Ruby objects to the database, and read them out again later.  
 * The views show data to users, most often in the form of HTML webpages.  
 * Controllers respond to requests from users, usually by coordinating the model and the view.  


### Rails installation on Linux

From a terminal window we'll install rvm (Ruby Version Manager) - which we'll use to download, compile, install and manage different versions or ruby. To install rvm, first install curl (which we'll use to install rvm), using the following command:

```text
    sudo apt-get install curl
````

Once installed, install rvm with the following two commands:

````text
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

    \curl -sSL https://get.rvm.io | bash -s stable

`````

Open a new terminal window, and install ruby

````text
    rvm install 2.3.1
`````

Once installation is complete, open a new terminal window and set the 2.3.1 version of ruby as the default

````text
    rvm use 2.3.1 --default
````

You may get an error: "RVM is not a function... You need to change your terminal emulator preferences to allow login shell." If that happens, you'll need to enable login shell for your terminal. On Ubuntu, from the Menu bar, go through the following steps:

 * "Edit"  
 * "Profile Preferences"  
 * "Command" tab   
 * Check "Run command as a login shell"  
 * Click "Close"  
 * Open another new terminal window so it takes effect  

Now run the 'rvm use 2.3.1 --default' command again.


### Install Rails

Rails comes as a Ruby "gem", which can be installed using the "gem" tool. In your terminal, run:

````text
    gem install rails --version 5.0.0
````

### Install NodeJS

Some libraries that Rails depends on require a JavaScript runtime to be installed. In your terminal, use Ubuntu's package manager to install the nodejs package:

````text
    sudo apt-get install nodejs
````