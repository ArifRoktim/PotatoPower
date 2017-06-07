# PotatoPower
APCS2 Final Project -- Tower Defense Game

Shakil Rafi, Alitquan Mallick, Arif Roktim

## What is it?
This project is a tower defense game. Enemies are spawned at the beginning of a path and they travel along it until they reach the endpoint.
While traveling down the path, towers, which are placed by the player, shoot at the enemies until they reach the endpoint or their health is diminished to zero.
Every time an enemy reaches the endpoint, the player loses a life. The game ends when the player loses all lives.

#### Launch instructions:
1. `$ git clone https://github.com/ArifRoktim/PotatoPower/`
2. `$ cd PotatoPower`
3. `$ processing Game/Game.pde`
4. Click the run button or press Ctrl-R

When launching the project, the player is presented with the main menu. Then, they click through a short tutorial.
The player can place and upgrade towers with their starter money during the setup phase.
When they're ready, the player can click the start button to make enemies begin to spawn.
Enemies will move along a path toward the end, towers will shoot the enemies, and the player will be rewarded with money for each enemy death.
The players can place and upgrade towers while enemies are spawning. 
The game ends when all the player's lives are gone or when all enemies are gone.

## How does it work?
Links to flowchart and uml diagram: [flowchart,](https://github.com/ArifRoktim/PotatoPower/blob/master/flow.pdf) [uml](https://github.com/ArifRoktim/PotatoPower/blob/master/uml.pdf)

#### Collision detection:  
We use a QuadTree to make collision detection more efficient by only checking for collisions between objects that can collide. Our main resource was: [link](https://gamedevelopment.tutsplus.com/tutorials/quick-tip-use-quadtrees-to-detect-likely-collisions-in-2d-space--gamedev-374)

#### The actual collision detection algorithm
All the hitboxes are just circles :)

#### Enemy detection by Towers
Towers detect enemies by having a large hitbox relative to their image sprite. When an enemy collides with this hitbox, it is added to the tower's internal queue of enemies to target.
When the enemy at the front of this queue goes out of range or dies, it is dequeued.

#### Enemy movement through the map
Each tile is assigned a numeric value. Enemies move by comparing the values of the tiles around it to the value of the tile it's currently on, and moving toward a tile that has a greater value.
