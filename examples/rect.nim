import ../nixel
import streams



proc drawColoredRect*(img: var Image,x,y:int=0,width:int=1,height:int=1,thickness:int=1,color:NColor= Black) =
  ## Draw a rectangle, (x,y) is the top left corner.
  ## Measures are on the outside 

  # Let's have every side a different color
  img.drawLine(x,y,height,thickness,Black) # left side
  img.drawLine(x,y,thickness,width,Red) # top side
  img.drawRevLine(x+width-1,y+height-1,thickness,width,Green) # bottom side
  img.drawRevLine(x+width-1,y+height-1,height,thickness,Blue) # right side

proc rect() =
  # Draw our image in memory
  let w = 128
  let h = 64
  var img1 = initImg(w, h)
  img1.fillWith(White)
  img1.drawColoredRect(10,10,24,48,8)
  img1.drawRect(56,16,36,36,8)

  img1.saveto("rect.png")
  echo("Drew to: rect.png")
rect()
