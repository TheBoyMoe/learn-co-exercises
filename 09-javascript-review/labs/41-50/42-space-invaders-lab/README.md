# Space Invaders Lab

## Instructions

Space flight is no joke, and neither is this lab. You're going to need to create two ES6 JS classes, `Spaceship` and `CrewMember`. These classes will pump out instances that are by default unable to interact with one another. A space ship will be inactive if it is created without a crew. And a crew member by default will be hanging out in the Cantina looking for a ride if they were not put inside a ship when it is initialized.

Crew members will also be unable to use their special abilities if they're not assigned to a ship. For example, a pilot cannot `engageWarpDrive` if s/he is not in a ship and, therefore, can't make the Kessel Run in less than twelve parsecs. Crew members also should be unable to perform certain actions that their positions are incapable of doing.

To have these two objects be aware of one another, we need to have the ship become aware of its crew members on instantiation. This will also require you to make sure a crew member becomes aware of their ship when they are added to it.


TLDR;
A ship cannot exist without a crew and an individual crew member can't use their special ability if not assigned to a ship.

![alt text](https://media.giphy.com/media/26uf9QPzzlKPvQG5O/giphy.gif "space ship gif")

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/space-invaders'>Space Invaders Lab</a> on Learn.co and start learning to code for free.</p>
