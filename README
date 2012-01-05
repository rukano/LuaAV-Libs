Libraries for easy coding in LuaAV
===================================

This library is for my personal use. If you like it, you can use it.
I won't concentrate much on programming elegance or so... the modules create a lot of globals and lots of stuff could be optimized. But anyway, this is what I use to make animations in LuaAV

~~~~~~~~~~~~~~
~Instructions~
~~~~~~~~~~~~~~

1. clone the repository or download the lib folder
2. rename that lib folder to 'rukano' (or whatever)
3. require files like:

require("rukano.Math")
require("rukano.Graphics")
require("rukano.Patterns")
win = require("rukano.Window")
require("rukano.SuperCollider")

--------------------------------------------------------------------------------

Patterns
========

This is an experimental module/library still under heavy developement. It intends tu simulate/emulate the behaviour of common Patterns like Pseq, Prand, Pwhite, etc...
There are much better ways to handle the inheritance and kind of classes, but I didn't wanted to include  another libraries, so I kept it simple.

SuperCollider
=============

I'm having trouble starting scsynth from Lua. It works but scsynth won't find some UGens and the default Synth... (weird)
At the moment only Synth:new and Synth:set are available. You could use all other commands by using osc messages from:
sc.osc:send("/cmd", value)

Graphics
========

Still a lot to do, but now you can draw some primitives and import models :)

Math
====

Just some functions to make my life easier. Heavily inspired by some SuperCollider functions

Notes
-----

* Pattern is the superclass for all other patterns.
* TODO: simulate he other patterns in the comment
* TODO: make a better class/inheritance system

Disclaimer
__________

* Don't blame me if it doesn't work.
* Have fun if it works.
* If you have suggestions or better implementations, please contact me.