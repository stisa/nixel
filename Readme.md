Nixel
=====
<sub>A pixel drawing utility in pure [nim](http://nim-lang.org/) - No external lib required</sub>

This is a simple lib that can draw `.png` files, abstracted over  [nimPNG](https://github.com/jabgqo/nimPNG).

Currently you can:
  - Fill a surface with a color
  - Draw lines ( left to right, right to left, oblique )
  - Draw rectangles
  - Save a surface to png

**Bonus**: draw simple equations in the format `# + # =` ( or any other combination of  
numbers, spaces, `+` , `=` )

Examples
--------

![tet](testdraw.png)

### [captcha.nim](examples/captcha.nim)
![noborder](examples/captcha.png)  
![border](examples/captchaBorder.png)
### [rect.nim](examples/rect.nim)
![rect](examples/rect.png)
### [square.nim](examples/square.nim)
Mhh this one is a bit tiny ![square](examples/square.png)

See [examples](https://github.com/stisa/nixel/tree/master/examples) for code.

Documentation
-------------

See code comments, or view `nim doc2` output [at my site](http://stisa.space/nixel)

Plans
-----
- convenience function for creating `NColor`, maybe `proc rgba(r,g,b,a:float):NColor` ( `proc rgb()` too)
- support saving sdl2 surfaces ( and maybe loading too? )

License
-------

[MIT](https://github.com/stisa/nixel/LICENSE)

