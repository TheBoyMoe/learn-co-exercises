Post.destroy_all
Author.destroy_all

author1 = Author.create(name: "Stephen King")
author2 = Author.create(name: "Ariana Huffington")
author3 = Author.create(name: "Horse Ebooks")


#this makes use of HEREDOCs, which you can read more about here, doc: https://en.wikipedia.org/wiki/Here_document
post1 = <<-POST1
  Last night I dreamt there is more to life than to bully friends.
  What has that got to do with Democrats, you probably wonder...
  The answer is here. Right here. Back in school my hair was silly.
  Nevermind about the details, but... In a nut-shell: And still,
  it was strange. Using Google, I found a 12-sided dice.
  Which would be nothing special but...
  POST1

post2 = <<-POST2
  It occurred to me that no matter what cards you are dealt,
  you need to enjoy the small joys. How is this related to Spam, you ask.
  Fair enough. OK, I will tell you something here now...
  Sometime around last year I loved movies. Yeah, just what it sounds like.
  In a nut-shell: And still, it was strange. I collided with the powers of a my computer,
  broken and gray. And here's why this matters...
  POST2

post3 = <<-POST3
  Last night I dreamt we simply need to realize to be so competitive.
  Does the responsibility lie with Links, you probably wonder...
  The answer is here. Right here. About the time I broke up with my
  ex I was totally into music. Whatever. So that's that.
  But something wasn't right. I stumbled upon a giant banana.
  POST3

Post.create(title: "Something about Democrats", description: post1, author: author1)
Post.create(title: "SPAM SPAM SPAM", description: post2, author: author2)
post = Post.create(title: "Links! Click Links!", description: post3, author: author3)
