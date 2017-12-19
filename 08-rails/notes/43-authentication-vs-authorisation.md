# Authentication and Authorization with Gems

## Learning Objectives

1. Understand the landscape of gems that can be used to do authorization and authentication in Rails.

## Authentication vs. Authorization

Two concepts that are related, often confused, and important to distinguish are authentication and authorization.

*Authentication* is determining who someone is. When I take money out of an ATM, the bank authenticates me with two authentication factors: my PIN and the secret key stored in the chip on my ATM card. Before I get on a plane, the TSA (the airline security organization in the U.S.) authenticates me by asking for my ID and using the extremely advanced facial recognition hardware embedded in human brains to verify that the ID matches my face. Usernames, passwords, and credentials all deal with authentication.

*Authorization* is determining whether someone should be able to do a particular thing. The bouncer at the club authenticates me by looking at my ID and then authorizes me to enter by looking at the list (though I am more typically asked to leave the premises).

## Authentication

In the first half of this unit we learned how to create our own authentication scheme.

Most security professionals will tell you NEVER to roll your own authentication logic. This is because, no matter what your experience level as a programmer, it's unlikely you are a match for the myriad tricks hackers are going to use to try to hack into your site. Forget to salt your passwords? You're open to rainbow table attacks. Use the wrong hashing algorithm? You're open to brute force attacks. Leave security to those who are experts at it!

There are two solutions to this problem. We've already learned the first: let someone else take care of logging users in! Rather than devoting your scarce resources to solving a solved problem, use the Omniauth gem. Let one of the Internet giants, like Facebook or Google, deal with authentication by leveraging the OAuth protocol. If Facebook gets hacked, you probably wouldn't have been any safer implementing your own authentication scheme.

Along the same lines as this solution is leveraging the Rails community's open source nature and using a battle tested gem to implement authentication. In the same way using the Omniauth gem can help you avoid implementing the OAuth specification incorrectly yourself, there are a host of gems the Rails community has built over the years to help you avoid having to implement authentication and authorization on your own.

One of the gems everybody loves almost as much as they hate it is Devise. It's without a doubt the leader in the authentication space and has over 3,000 commits in it's seven-year history. It's heavily metaprogrammed and modularized and has a solution to just about any need your authentication scheme might require. Our biggest complaint with Devise is that it often obscures what's going on due to its metaprogramming, which makes it hard to change if its configuration options don't account for EXACTLY your use case. The great thing about Devise is it also offers some authorization options as well.

Other gems worth looking at in this space are [Warden](https://github.com/hassox/warden) (which Devise is based around) and [Authlogic](https://github.com/binarylogic/authlogic).

## Authorization

Hey, can I delete this file?

It's a surprisingly loaded question. Did I create the file? Do I own it? What does it mean to own a file? Can I write to the file? If I can write to a thing, can I delete it?

These are questions of authorization.

Authorization deals with WHAT a user is allowed to do once we know WHO that user is. Can this particular user delete a post? Can they view posts written by other users? Authorization helps you answer these questions.

Although Devise doesn't have out-of-the-box support for authorization, it's common to implement "roles" using Devise. Roles allow us to segment our users into types or kinds of users. For example, admins, teachers, and students. By leveraging Active Record's `enum` feature, you can define a user as having a specific role. If you have simple enough authorization requirements this might be enough.  However, if your roles get more complicated you might want to bring in another gem, [Rolify](https://github.com/RolifyCommunity/rolify), to do the heavy lifting.

You can pair the concept of roles with other gems that allow you to specify which "abilities" or "policies" users, or types of users, have. For example, we could say that admins have the "ability" to read, write, and delete any post.

[CanCanCan](https://github.com/CanCanCommunity/cancancan) and [Pundit](https://github.com/elabs/pundit) are the leaders in this space. If you are a fan of RailsCasts, the original CanCan gem (so-named to answer the question: what *can* a user do?) was written by the series's creator!
