
# The Great Mental Snap (Ruby - Documentation)

By Coen Drexler, started at 3:00PM, 2-9-2019


## General Description

'The Great Mental Snap' is a single-player terminal application built to simulate the colloquially popular card game 'Snap', using the Ruby programming language.

The intention of this project was to expand and also reinforce my personal understanding of practically implementing the fundamental concepts of program development and modular, DRY code writing, in order to realistically simulate the interactive mechanics of a concept reliant upon both logic and mathematics.  

This application operates using text/character input, which is evaluated against a simulated opponent's reaction speed for either a win or lose case.  This simulated reaction time is adjustable, allowing for variance in difficulty.  Card totals are tracked and displayed as they change, alongside a point counter.  

'The Great Mental Snap' operates on [standard 'Snap' rules](https://en.wikipedia.org/wiki/Snap_(card_game)), except with inverted card accumulation rules.  Instead of *collecting* all the cards, the user aims to **get rid** of each card in their hand.  To start each game, a shuffled deck is evenly divided between the players.  For each round of the game, one card is removed from each players hand, and both are simultaneously revealed.  If the cards match, (by index position), the player with the fastest reaction time to call 'Snap' will win that round, and all cards (including currently played cards) are placed into the losing players hand.  If the cards do not match, the process is repeated until either a snap occurs and distributes the card totals again, or until a player successfully empties his hand, winning the game.

The only unmentioned additional *option* included for this project on top of the standard 'Snap' card game logic is an option for suit based comparison instead of index position.

## Usage guide

Playing instructions:

1)  Open rungame.rb
2)  When welcomed, enter any set of characters to move to the game setup menu. 
3)  If required, enter R to read the game rules. 
4)  When prompted, enter your desired difficulty.
5)  When prompted, enter your desired card comparison logic.
6)  After the game has initialized, when prompted, enter any character to display cards.
7) If you wish to snap, hit enter.  

### Installation:  

1) If you don't already have Ruby installed, you can download it from and follow the installation instructions available [here](https://www.ruby-lang.org/en/documentation/installation/).  
2) Download and uncompress the game files in their given file structure.
3)  Install Ruby Bundler if you haven't already.
4)  Run `bundle install`
5)  Change your working directory the now unzipped 'Main' folder.
6)  Run `ruby run_game.rb` in the command line to access and execute the game initializing ruby file.
7)  If this does not work 


## Idea/Project Motivation

During my first and second week learning fundamental programming skills attending [Coder Academy's Fast Track Program](https://coderacademy.edu.au/), 

During the initial planning phase, I found myself motivated to go in a number of directions, searching for a project that would both demonstrate proficient use of fundamental concepts in software development, and also reflect my personal interests as a developer.

Of these, the most actively researched and pursued potential projects were:


-   `A terminal based drum machine/mixer/audio file writer`
-   `A MIDI file parsing guitar tablature generation tool`
-   `A PDF/e-book file organisation tool, with a read, bookmark, and search function`
-   `A command line operated VST audio plugin for a Digital Audio Workstation`

I decided for each of these that I would be limited by the scope of the nature of a terminal application, the lack of available language support, the timeframe and complexity involved outweighing the educational utilitarianism of a dense yet straightforward alternative, or that I'd be missing particular features I was requiring out of my project.  

After deciding against pursuing these projects, I turned my focus to projects revolving around logic, namely card games.  In my initial experimentation, I considered implementing a drawn GUI, but I found it counter-intuitive to the process of cementing my basic programming skills.  Instead, I examined what input and output a simple terminal application could utilise, and found the concept of a reflex/reaction based application a perfect contrast to the simple interface a terminal offers.  

'Snap' was a particularly appealing project in the simple nature of how it operates, entertaining the player by nature of a psychological/physiological stimulation, as opposed to the sensory focused stimulation typical applications utilise.  Of course, a conjunction of the two provides increased functionality and potential, but for the criteria of this project a purely terminal application is more suitable.

The concept of ruby-driven audio processing is certainly still extremely interesting to me, and in the near future I would love to revisit the idea of building a VST that cooperates with own DAW of choice.  

## Features and Functionality

When originally designing 'The Great Mental Snap', I required several core features out of my finished program.

### Core Features

The culminative purpose of these individual features was that it be able to mathematically and algorithmically recreate the logic of playing a 'Snap' type card game.  There were several layers to executing this reliably, but by utilising modular development, the task became much simpler.

I was able to construct each level of the program logic so that it can collectively cascade in a manner that greatly simplifies the process of simulating card game math.  


Each card object holds the values required for the 'Snap' comparison mechanic, and are each in turn initialized by and grouped under a deck object.  Within this deck object, a constructor method utilises a simple algorithm to assign the required values, numerically 1 - 13, for each of the 4 suits.  The result is shuffled randomly each time it is initialized, so when reusing the same reference deck class for repeated subsequent games, a new distribution is always inevitable.

This 'game-ready deck' is then passed into an internal deck sorting method, which maps the first 26 cards to one container, and the remaining 26 cards to a second container.  These represent each players remaining hand.  

The process is repeated, initialized and controlled by a gameplay method within the core game logic class.  
And finally, this core game logic class is itself called by the rungame ruby file, connecting the modular chain of card game logic to the user.  Within this rungame file, the user is prompted for the required arguments needed to create the desired game.
For each round of the game, one card is removed from each container and placed into a complementary container for comparison and output to the display.  By evaluating whether the cards are a match *before* allowing for user input, I was able to pass the true/false match value to a method that determines the window of time available to successfully register input.  This means that for each round the cards are not a match, the timeout is set, whereas in an initial build of this program, the timeout value was always assigned a random number, which was unsuitable for user experience.

Within each of these individual objects, there are functions I have written to perform *each* logical step of the game.  

### Extensible Features

- Using a random number generator in conjunction with a ranged arguments allows for human behaviour in the automated reaction time, however, implementing an additional adaptive difficulty setting, (constantly readjusting a mean average reaction time variable), would add dynamicism to interaction, and a realistic sense of adaptation in the simulated opponent.
- More extensive art and perhaps ruby GUI gem integration (such as [Curses](https://rubygems.org/gems/curses/versions/1.2.4) or [Gosu](https://rubygems.org/gems/gosu) would contribute massively to user ability in easily and effectively deciphering different card values and suits.  
- 


## Code Structure

After confirming the individual project details, requirements and overall elements, an initial draft build was done to explore exactly how the execution of the game logic would be achieved.  This consisted of a single ruby file, 2 classes, and incredibly lacking optimization for efficiency/modularization.  At the time, this was necessary to gain a grounded understanding of how to mathematically distribute my required variables and objects, and gave an excellent reference when it came to creating a more modular reformat of this project, with a focus on shared variables.  

Focusing more on refining the code and logic, I decided that 3 classes would allow me to divide the steps I needed into user interaction, game generation/flow control, and card generation/flow control.  This worked for a simple implementation, but it immediately became clear that it would make far more sense to use 4 modules instead of 3, as it would allow me to split the card logic into two parts, and classify one as a deck object, forming an intermediary initializer/controller for my required card objects.  


## Build Status

'The Great Mental Snap' is in a proof-of-concept state, performing the basic functions I established as requirements during my design and planning process.  




## Design and Planning process

- TRELLO

- IO DIAGRAM

## Testing

Given the timeframe and individual nature of the terminal application development project, I found the most educational aspect to be the experimentation with algorithm design, which largely limited the amount of testing that would be necessary.  In order to consistently get the results I required from my application and the individual modules that make it up

## Accessibility

Colour and timing 


## Ethics
