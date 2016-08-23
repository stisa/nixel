Nixel
=====
<sub>A pixel drawing utility in pure [nim](...) - No external lib required</sub>

This is a simple lib that can draw `.png` files, abstracted over a fork of [nimage](...) that I got  
compiling again under [nim](...) `0.14.2` . ( Yes I plan on opening a pull request for it ). 
Currently you can:
  - Fill a surface with a color
  - Draw lines ( left to right, right to left )
  - Draw rectangles
  - Save a surface to png

**Bonus**: draw simple equations in the format `# + # =` ( or any other combination of  
numbers, spaces, `+` , `=` )

Examples
--------

See [examples](...) for code.

Documentation
-------------

See code comments, or view `nim doc2` output [at my site](http://stisa.space/nixel)

Plans
-----
- convenience function for creating `NColor`, maybe `proc rgba(r,g,b,a:float):NColor` ( `proc rgb()` too)
- nimage supports loading too, so verify and expose it. ( Requires `zlib` ?)
- support saving sdl2 surfaces ( and maybe loading too? )

License
-------

TODO: verify mit compatible, then [MIT](...)