# Poison - The high performance cross-platform desktop/mobile UI engine
Poison is a high performance cross-platform desktop/mobile UI engine written in D using dsfml.
It's based on the idea of having a UI library that is compatible with games and multithreaded applications.

Generally it's hard to write UI's for games or handle UI's with highly multithreaded applications, but the core
of Poison manages that very well.

## Why another UI engine?
Poison was born, because right now there isn't any really nice choice to render UI's in D when it comes to game development. There are plenty UI libraries, but most are for native rendering and not through libraries such as sfml, which makes it really hard to implement UI's with those for ex. games written in dsfml.

## Why not extend existing libraries to support dsfml then?
Poison is being used in a game project and by having developed the UI engine ourselves, we have full control of how the rendering goes, meaning we could optimize it how we wanted and have it fit to our games need. It also had us apply a sense of multithreading/concurrency pattern from the very beginning as it would be hard to apply that to an existing library without breaking changes. At the end of the day, writing a new library/engine was just much easier.

## How do I use poison?
There will be posted a few guides in the wiki soon, but for now keep an eye open as it's still in its early alpha-phase. Which means nothing is stable as it is and components are still being made.

A lot of stuff can change until we reach our first revision.

## How do I contribute?
Keep your eyes open for updates, there'll soon be a contribution guide. As for now you can fork the project and simple create pull requests with whatever contributions you have. We're not so strict as it is right now.
