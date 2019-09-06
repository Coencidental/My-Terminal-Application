
# Coen Drexler - The Great Mental Snap (Term 1 Terminal Application Project, Coder Academy)

By Coen Drexler, started at 3:00PM, 2-9-2019


## General Description

'The Great Mental Snap' is a single-player terminal application built to simulate the colloquially popular card game 'Snap', using the Ruby programming language.

The intention of this project was to expand and also reinforce my personal understanding of practically implementing the fundamental concepts of program development and modular, DRY code writing, in order to realistically simulate the interactive mechanics of a concept reliant upon both logic and mathematics.  

![enter image description here](https://raw.githubusercontent.com/Coencidental/My-Terminal-Application/master/Documentation/Welcomemessage.PNG)

This application operates using text/character input, which is evaluated against a simulated opponent's reaction speed for either a win or lose case.  This simulated reaction time is adjustable, allowing for variance in difficulty.  Card totals are tracked and displayed as they change, alongside a point counter.  

'The Great Mental Snap' operates on [standard 'Snap' rules](https://en.wikipedia.org/wiki/Snap_(card_game)), except with inverted card accumulation rules.  Instead of *collecting* all the cards, the user aims to **get rid** of each card in their hand.  To start each game, a shuffled deck is evenly divided between the players.  For each round of the game, one card is removed from each players hand, and both are simultaneously revealed.  If the cards match, (by index position), the player with the fastest reaction time to call 'Snap' will win that round, and all cards (including currently played cards) are placed into the losing players hand.  If the cards do not match, the process is repeated until either a snap occurs and distributes the card totals again, or until a player successfully empties their hand, winning the game.

The only unmentioned additional *option* included for this project on top of the standard 'Snap' card game logic is an option for suit based comparison instead of index position.

## Usage guide

Playing instructions:

1)  Change your working directory to the Snap file
2)  Enter `ruby run_game.rb`
3)  When welcomed, enter any set of characters to move to the game setup menu. 
4)  If required, enter R to read the game rules. 
5)  When prompted, enter your desired difficulty.
6)  When prompted, enter your desired card comparison logic.
7)  After the game has initialized, when prompted, enter any character to display cards.
8) If you wish to snap, hit enter.  Otherwise, enter nothing.  

Upon running the game, you will be prompted if you'd like to read a more extensive set of rules.

### Installation:  

1) If you don't already have Ruby installed, you can download it from and follow the installation instructions available [here](https://www.ruby-lang.org/en/documentation/installation/).  
2) Download and uncompress the game files in their existing file structure.
3)  Install Ruby Bundler if you haven't already.
3.5)  *Run `bundle install`*
4)  Change your working directory the now unzipped 'Main' folder.
5)  Run `ruby run_game.rb` in the command line to access and execute the game initializing ruby file.


## Idea/Project Motivation

During my first and second week of learning fundamental programming skills while attending [Coder Academy's Fast Track Program](https://coderacademy.edu.au/), it was posed that we'd have to built applications during the course, so I did my best to try to have a fairly comprehensive list of potential projects to start on, however, as I gained a better perspective on the requirements, (and a better understanding of my own limitations), I found myself unsure of where to start.

When it came time to properly start this project, I decided to instead focus on what I was looking to demonstrate with my project.  

During the initial planning phase, I found myself motivated to go in a number of directions, searching for a project that would both demonstrate proficient use of the fundamental concepts in software development, and also allow me to exercise some of creativity and reflect my personal interests as a developer.

Of these, the most actively researched and pursued potential projects were:


-   `A terminal based drum machine/mixer/audio file writer`
-   `A MIDI file parsing guitar tablature generation tool`
-   `A PDF/e-book file organisation tool, with a read, bookmark, and search function`
-   `A command line operated VST audio plugin for a Digital Audio Workstation`

I decided for each of these that I would be either: limited by the scope of the nature of a terminal application, the lack of available language support, the timeframe and complexity involved outweighing the educational utilitarianism of a more straightforward alternative, or that I'd be missing particular features I was desiring out of my project.  

The common features that held my interest in my initial research phase were more intricate concepts of input/output, particularly those involving audio interpretation/manipulation.  Rather than focusing on what I defined as sufficient complexity in the project idea, I found myself more interested in the relationship between the three contributing elements: the user/s, the input, and the output.  I decided early on that when using a relatively simple input/output environment, I would be able to achieve a far more meaningful interaction with the user if I focused on taking advantage of them, rather than allowing them to take advantage of the program.  

After deciding against pursuing the previously mentioned projects, I turned my focus to projects revolving around logic, namely card games.  In my initial experimentation, I considered implementing a drawn GUI, but I found it counter-intuitive to the process of cementing my basic programming skills.  Instead, I examined what input and output a simple terminal application can utilise to engage a user, and found the simple idea of a reflex/reaction based application far more appealing and genuinely engaging than any of the alternatives.  

'Snap' was a particularly appealing project in the simple nature of how it operates, entertaining the player by psychological/physiological stimulation, rather than sensory focused stimulation *typical* applications utilise.  Of course, a conjunction of the two provides exponentially increased functionality and potential, but for the criteria and timeframe of this project, a purely terminal based application was more suitable than trying to integrate a GUI.  Even so, I aimed to construct a relatively pleasant interface, relying on minimalism to convey the same variables.
 
~

![enter image description here](https://raw.githubusercontent.com/Coencidental/My-Terminal-Application/master/Documentation/gameplay.PNG)

The concept of ruby-driven audio processing is certainly still extremely interesting to me, and in the near future I would love to revisit the idea of building a VST audio effect from the ground up.  

## Features and Functionality

When originally designing 'The Great Mental Snap', I required several core features out of my finished program:

### Core Features

The culminative purpose of these individual features was that it be able to mathematically and algorithmically recreate the logic of playing a 'Snap' type card game.  There were several layers to executing this reliably, but by utilising modular development, the task became much simpler.

I was able to construct each level of the program logic so that it can collectively cascade in a manner that greatly simplifies the process of simulating card game math.  


Each card object holds the values required for the 'Snap' comparison mechanic, and are each in turn initialized by and grouped under a deck object.  Within this deck object, a constructor method utilises a simple algorithm to assign the required values, numerically 1 - 13, for each of the 4 suits.  This both more elegant a solution, and also a much more time friendly workaround.

This deck result is shuffled randomly each time it is initialized, so when reusing the same reference deck class for repeated subsequent games, a new distribution is always guaranteed.

This 'game-ready deck' is then passed into an internal deck sorting method, which maps the first 26 cards to one container, and the remaining 26 cards to a second container.  These represent each players remaining hand.  

The process is repeated, initialized and controlled by a gameplay method within the core game logic class.  
And finally, this core game logic class is itself called by the rungame ruby file, connecting the modular chain of card game logic to the user.  Within this rungame file, the user is prompted for the required arguments needed to create the desired game.
For each round of the game, one card is removed from each container and placed into a complementary container for comparison and output to the display.  By evaluating whether the cards are a match *before* allowing for user input, I was able to pass the true/false match value to a method that determines the window of time available to successfully register input.  This means that for each round the cards are not a match, the timeout is set, whereas in an initial build of this program, the timeout value was always assigned a random number, which was unsuitable for user experience.

Within each of these individual objects, there are functions I have written to perform *each* logical step of the game.  

Graphically, this application features the incorporation of both 'colorize' and 'artii' to enhance the visual experience when trying to interpret the values of each card, as well as general gameplay and navigation/prompting.  

In addition to the core game logic, I aimed to include some element of humanization, to avoid a user experience of quantization and monotony.  I achieved this through the incorporated difficulty configuration.  By assigning a difficulty variable one of 3 values, I was able to create three levels of *variable* difficulty byusing them to define the range a random number will generate within.  This ensures randomness, but also limits and configures the nature of this randomness to engage the user more accordingly.

### Extensible Features

The code of this application is designed to be modular.  In the future therefore, this concept could be taken further by including:

- Using a random number generator in conjunction with a ranged arguments allows for human behaviour in the automated reaction time, however, implementing an additional adaptive difficulty setting, (constantly readjusting a mean average reaction time variable), would add dynamicism to interaction, and a realistic sense of adaptation in the simulated opponent.
- More extensive art and perhaps ruby GUI gem integration (such as [Curses](https://rubygems.org/gems/curses/versions/1.2.4) or [Gosu](https://rubygems.org/gems/gosu) would contribute massively to user ability in easily and effectively deciphering different card values and suits.  
- Allowing for additional players, particularly other human users, and assignable input for multi-player games.


## Code Structure

After confirming the individual project details, requirements and overall elements, an initial draft build was done to explore exactly how the execution of the game logic would be achieved.  This consisted of a single ruby file, 2 classes, and incredibly lacking optimization for efficiency/modularization.  At the time, this was necessary to gain a grounded understanding of how to mathematically distribute my required variables and objects, and gave an excellent reference when it came to creating a more modular reformat of this project, with a focus on shared variables.  

Focusing more on refining the code and logic, I decided that 3 classes would allow me to divide the steps I needed into user interaction, game generation/flow control, and card generation/flow control.  This worked for a simple implementation, but it immediately became clear that it would make far more sense to use 4 modules instead of 3, as it would allow me to split the card logic into two parts, and classify one as a deck object, forming an intermediary initializer/controller for my required card objects.  

![Class Interactions](https://raw.githubusercontent.com/Coencidental/My-Terminal-Application/master/Documentation/Class%20Interactions.png)




## Build Status

'The Great Mental Snap' is in a proof-of-concept state, at this point capable of performing the functions I established as requirements during my design and planning process.  

As it stands, this application is in its third iteration, deriving from its predecessor builds to more efficiently independently perform each required process.


## Design and Planning process

When first approaching this project, I found it initially difficult to conceive of something that was within the confines of my ability, while simultaneously not sacrificing creativity.  



![Overall gameplay logical processes breakdown](https://raw.githubusercontent.com/Coencidental/My-Terminal-Application/master/Documentation/DevPlan.png)


## Testing

Given the timeframe and the independent nature of the terminal application development project, I found the most educational factor of the entire development process to be the experimentation with algorithm design it required, during which time a large number of the fundamental holes in the reconstructed game logic were identified and corrected.  This largely limited the amount of testing required, however in hindsight, it is evident that adopting a far more simultaneous Test Driven Development approach to this project would have allowed me to correct those issues before they were ever coded.  

In order to consistently get the results I required from my application and the individual modules that make it up, I kept the core logic that it operates on as simple as possible, which was all that was necessary for a card game such as 'Snap'.

Tests were written regardless for the core functions of the game to ensure they return the correct result.  

Additionally, by including card counting and displaying logic in the game, I mitigated the need to have a specific test for card distribution throughout the game. 

## Accessibility

In order to add accessibility enchancing features to my application, I addressed what I consider to be the main drawback of this nature of program.  The only necessary sense for playing snap in this application is sight, so my aim was to improve the user ability to decipher key elements of gameplay.

### Color Differentiation

For important elements of gameplay, namely when being prompted with a win or loss message during each round and when reviewing all round results at the conclusion of a match, I ensured there was a consistent binary color theme.  Blue and red predominately represent actions positive and negative towards gameplay respectively.

### Increased Output Size and Difficulty Configuration

In addition to color, user ease of text interpretation was my second priority.  I implemented a gem to convert key text to ASCII art (see [Artii]([https://github.com/miketierney/artii](https://github.com/miketierney/artii))) so that it would be both more aesthetically pleasing, and also more discernible to any user trying to interpret it.

In conjunction with this, the time interval the user is allocated (depending on the difficulty chosen) is an important feature in providing an enjoyable yet challenging experience for any user.  This design was implemented primarily to provide a challenge to the user, but it is also contrarily useful in ensuring the game is playable and legible to all types of potential players.







## License

**Copyright (c) 2019 Coen Drexler**  for  [Coder Academy](https://coderacademy.edu.au/).

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to  use, copy, modify, merge, publish, distribute, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
