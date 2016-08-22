import ../draw #../nimage/nimage
import streams

proc drawSquare*(img: var Image,x,y:int=0,width:int=1,height:int=1,thickness:int=1) =
  img.drawLine(x,y,height,thickness,NColor(0x000000FF)) # black top left
  img.drawLine(x+width,y,height,thickness,NColor(0xFF0000FF)) # Red top right side
  img.drawLine(x+width,y+height,thickness,width,NColor(0x00FF00FF)) # Green bottom right side
  img.drawLine(x,y+height,thickness,width,NColor(0x0000FFFF)) # Blue bottom left side


proc square() =
  # Draw our image in memory
  var img1 = createImage(4,4) # Create a 4 by 4 pixels image
  img1.fillWith(NColor(0xFFFFFFFF)) # Set all pixel in the img to white
  img1.drawSquare(1,1,1,1,1) # Draw a 2x2 square, with every pixel a different color
  
  # Output our image to a .png
  var out1 = newFileStream("square.png", fmWrite)
  img1.save_png(out1)
  out1.close()

  echo("Drew to: square.png")

square()