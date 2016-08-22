import ../draw #../nimage/nimage
import streams


proc drawSquare*(img: var Image,x,y:int=0,color:NColor=NColor(0x000000FF)) =
  ## Draw a rectangle, (x,y) is the top left corner.
  ## Measures are on the outside 
  
  img.drawLine(x,y,1,1,Black) # left side
  img.drawLine(x,y+1,1,1,Red) # top side
  img.drawRevLine(x+1,y,1,1,Green) # bottom side
  img.drawRevLine(x+1,y+1,1,1,Blue) # right side



proc square() =
  # Draw our image in memory
  var img1 = createImage(4,4) # Create a 4 by 4 pixels image
  img1.fillWith(NColor(0xFFFFFFFF)) # Set all pixel in the img to white
  img1.drawSquare(1,1) # Draw a 2x2 square, with every pixel a different color
  
  # Output our image to a .png
  var out1 = newFileStream("square.png", fmWrite)
  img1.save_png(out1)
  out1.close()

  echo("Drew to: square.png")

square()