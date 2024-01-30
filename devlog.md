
## 1/27  
Decided to create breakout because part of the point of game 2 was to reuse assets from the first game.  
The angle problem was a little easier this time.  
Being able to steal stuff from other project is nice.
In about an hour I was able to get the wall, paddle, and ball bouncing. And some of that time was spent figuring out how godot works with copying scenes over.

## 1/30
Had to do a bit of a hacky workaround for removing lives. I put the GameState.remove in the UI script.
I would have prefered to have it somewhere else.
I originally had it in the bounds.gd script and also hooked up with the same _on_body_entered signal.
Problem there was that the signals don't seem to execute in any particular order, so the lives were getting
updated after the label was updated.
Another solution would be to do the update in bounds and then just update the label in the UI's _process
function or something, but I felt the way I'm currently doing makes more sense since we don't need to update
the label every frame in this case.
