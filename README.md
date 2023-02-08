# PR3-EE-Doors
Lua code to use and make your own EE inspired doors and gates.

Setup:

1- Place your door, open door, gate, and closed gate in a grid like:

{door, open door}

{gate, closed gate}

starting from x=0 and the door being at -2 y (you can change how this works from activatekey() function)
the main functions uses "color" which is the xpos of the grid (xpos.2) so you should have 0,1,2... as your door/gate id's

2- For the keys, all you need to do is make a block that sets the keytimer of your selected color (variable) to the constant (FOUR). you can also add restrictions like not do it if the key is already on from key states so it doesnt reset as you hold the key.

That's it. You should have your EE door/gate system ready!
