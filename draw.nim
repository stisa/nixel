import nimage/nimage

export nimage.Image, nimage.create_image, nimage.NColor, nimage.save_png

proc fillWith*(img: var Image,color:NColor=NColor(0xFFFFFFFF)) = 
  for pix in img.data.mitems: pix = NColor(color) ## Loop over every pixel in `img` and sets its color to `color`

proc drawLine*(img: var Image,x,y:int=0,thickness:int=1,length:int=1,color:NColor=NColor(0x000000FF)) = # TODO: orientation to draw oblique lines
  for i in y..y+thickness-1:
    for j in x..x+length-1:
      img[i,j] = NColor(color)

proc drawRect*(img: var Image,x,y:int=0,width:int=1,height:int=1,thickness:int=1,color:NColor=NColor(0x000000FF)) =
  img.drawLine(x,y,height,thickness,NColor(0x000000FF)) # left side
  img.drawLine(x+width,y,height,thickness,NColor(0xFF0000FF)) # right side
  img.drawLine(x+width,y+height,thickness,width,NColor(0x00FF00FF)) # bottom side
  img.drawLine(x,y+height,thickness,width,NColor(0x0000FFFF)) # top side

when isMainModule:
  import streams
  proc main() =
    let w = 4
    let h = 4
    var img1 = createImage(w, h)
    img1.fillWith(NColor(0xFFFFFFFF))
    #img1.drawLine(10,10,15,60) 
    img1.drawRect(1,1,1,1,1)
    var out1 = newFileStream("testdraw.png", fmWrite)
    img1.savePng(out1)
    out1.close()
    echo("Drew to: testdraw.png")
  main()