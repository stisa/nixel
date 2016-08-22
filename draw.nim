import nimage/nimage

##Exports: nimage.Image, nimage.create_image, nimage.NColor, nimage.save_png
export nimage.Image, nimage.create_image, nimage.NColor, nimage.save_png

type Colors* {.pure.} = enum
  ## Common colors used for testing
  black = NColor(0x000000FF)
  blue = NColor(0x0000FFFF)
  green = NColor(0x00FF00FF)
  red = NColor(0xFF0000FF)
  white = NColor(0xFFFFFFFF)
  


proc fillWith*(img: var Image,color:NColor=NColor(0xFFFFFFFF)) =
  ## Loop over every pixel in `img` and sets its color to `color` 
  for pix in img.data.mitems: pix = NColor(color) 

proc drawLine*(img: var Image,x,y:int=0,thickness:int=1,length:int=1,color:NColor=NColor(0x000000FF)) = # TODO: orientation to draw oblique lines
  ## Draw a line at (x,y) going from left to right

  for i in y..y+thickness-1:
    for j in x..x+length-1:
      if(i>=img.height or i<0 or j>=img.width or j<0):continue # avoid going oob
      img[i,j] = NColor(color)

proc drawRevLine*(img: var Image,x,y:int=0,thickness:int=1,length:int=1,color:NColor=NColor(0x000000FF)) = # Draw from right to left
  ## Draw a line at (x,y) going from right to left

  for i in countDown(y,y-thickness+1):
    for j in countDown(x,x-length+1):
      if(i>=img.height or i<0 or j>=img.width or j<0):continue # avoid going oob
      img[i,j] = NColor(color)

proc drawRect*(img: var Image,x,y:int=0,width:int=1,height:int=1,thickness:int=1,color:NColor=NColor(0x000000FF)) =
  ## Draw a rectangle, (x,y) is the top left corner.
  ## Measures are on the outside 
  var hft: int = int(thickness/2) # This is used to center lines
  if(hft==0):hft=1
  #echo "hft: "& $hft
  img.drawLine(x,y,height,thickness,color) # left side
  img.drawLine(x,y,thickness,width,color) # top side
  img.drawRevLine(x+width-hft,y+height-hft,thickness,width,color) # bottom side
  img.drawRevLine(x+width-hft,y+height-hft,height,thickness,color) # right side

proc drawRect2*(img: var Image,x,y:int=0,width:int=1,height:int=1,thickness:int=1,color:NColor=NColor(0x000000FF)) =
  ## Draw a rectangle, (x,y) is the top left corner.
  ## Measures are on the outside 
  var hft: int = int(thickness/2) # This is used to center lines
  if(hft==0):hft=1
  #echo "hft: "& $hft
  img.drawLine(x,y,height,thickness,NColor(0x000000FF)) # left side
  img.drawLine(x,y,thickness,width,NColor(0xFF0000FF)) # top side
  img.drawRevLine(x+width-hft,y+height-hft,thickness,width,NColor(0x00FF00FF)) # bottom side
  img.drawRevLine(x+width-hft,y+height-hft,height,thickness,NColor(0x0000FFFF)) # right side


when isMainModule:
  import streams
  proc main() =
    let w = 8
    let h = 8
    var img1 = createImage(w, h)
    img1.fillWith(NColor(0xFFFFFFFF))
    #img1.drawLine(1,1,1,2)
    #img1.drawRevLine(2,2,1,2) 
    img1.drawRect(0,0,8,8,1)
    img1.drawRect(2,2,8,8,2)
    var out1 = newFileStream("testdraw.png", fmWrite)
    img1.savePng(out1)
    out1.close()
    echo("Drew to: testdraw.png")
  main()