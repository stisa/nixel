import nimage/nimage
import streams

## Exports
## -------
## nimage.Image, nimage.create_image, nimage.NColor, nimage.save_png
export nimage.Image, nimage.create_image, nimage.NColor, nimage.save_png

const
  ## Common colors used for testing
  Transparent* = NColor(0x00000000)
  Black* = NColor(0x000000FF)
  Blue* = NColor(0x0000FFFF)
  Green* = NColor(0x00FF00FF)
  Red* = NColor(0xFF0000FF)
  Purple* = NColor(0xFF00FFFF)
  White* = NColor(0xFFFFFFFF)
  HalfTBlack* = NColor(0x00000088) ## HalfT<Color> colors are <color> at half alpha
  HalfTBlue* = NColor(0x0000FF88)
  HalfTGreen* = NColor(0x00FF0088)
  HalfTRed* = NColor(0xFF000088)
  HalftWhite* = NColor(0xFFFFFF88)
  
proc fillWith*(img: var Image,color:NColor=NColor(0xFFFFFFFF)) =
  ## Loop over every pixel in `img` and sets its color to `color` 
  for pix in img.data.mitems: pix = NColor(color) 

proc drawLine*(img: var Image,x,y:int=0,thickness:int=1,length:int=1,color:NColor=NColor(0x000000FF)) = # TODO: orientation to draw oblique lines
  ## Draw a line at (x,y) going from left to right
  for i in y..y+thickness-1:
    if(i>=img.height or i<0 ):continue
    for j in x..x+length-1:
      if(j>=img.width or j<0):continue # avoid going oob
      img[i,j] = NColor(color)

proc drawRevLine*(img: var Image,x,y:int=0,thickness:int=1,length:int=1,color:NColor=NColor(0x000000FF)) = # Draw from right to left
  ## Draw a line at (x,y) going from right to left
  for i in countDown(y,y-thickness+1):
    if(i>=img.height or i<0):continue 
    for j in countDown(x,x-length+1):
      if(j>=img.width or j<0):continue # avoid going oob
      img[i,j] = NColor(color)

proc drawObliqueLine*(img: var Image, x,y:int=0, thickness :int= 1,length:int=1,color:NColor=Black ) =
  let boundx = x+int 1.4*length.float # x2 = x1+length*cos45
  let boundy = y+int 1.4*length.float
  let ht = int thickness/2
  for i in y..boundy:
    if(i>=img.height or i<0 ):continue 
    for j in x..boundx:
      if(j>=img.width or j<0):continue # avoid going oob
      if(j<=x+i+ht and j>=x+i-ht):
        img[i,j] = color

proc drawRect*(img: var Image,x,y:int=0,width:int=1,height:int=1,thickness:int=1,color:NColor= Black) =
  ## Draw a rectangle, (x,y) is the top left corner.
  img.drawLine(x,y,height,thickness,color) # left side
  img.drawLine(x,y,thickness,width,color) # top side
  img.drawRevLine(x+width-1,y+height-1,thickness,width,color) # bottom side
  img.drawRevLine(x+width-1,y+height-1,height,thickness,color) # right side

proc saveImageTo*(img:Image,filename:string) =
  ## Convience function. Saves `img` into `filename`
  var file = newFileStream(filename, fmWrite)
  img.save_png(file)
  file.close()

proc drawplus (img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let hr,wr = 5 # hardcoding is a bad idea
  img.drawLine(x+1+int wr/2,y+3,hr,1,color) # vertical line
  img.drawLine(x+1,y+3+int hr/2,1,wr,color) #horizontal line

proc drawequal (img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let hr,wr = 5 # hardcoding is a bad idea
  img.drawLine(x+1,y+4,1,wr,color) # vertical line
  img.drawLine(x+1,y+4+int hr/2,1,wr,color) #horizontal line

proc draw0 (img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let
    hr = int ptsize/2 + 1
    wr = int ptsize/2 - 1 
  img.drawRect(x+int wr/2,y+int hr/2,2,2,1,color) # dot inside the 0 
  img.drawRect(x+1,y+1,wr,hr,1,color)

proc draw1 (img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let
    hr = int ptsize/2 + 1
    wr = int ptsize/2 - 1 
  img.drawLine(x+1+int wr/2,y+1,hr,1,color) # vertical line
  img.drawLine(x+1,y+hr,1,wr,color) #horizontal line
  img.drawRevLine(x+int wr/2,y+2,1,1,color) # oblique line 1/2
  img.drawRevLine(x+int wr/2,y+3,1,2,color) # oblique line 2/2

proc draw2(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+1,y+1,1,wr,color) # top
  img.drawLine(x+wr,y+1,int hr/2,1,color) # right
  img.drawLine(x+1,y+int hr/2,1,wr,color) # middle
  img.drawLine(x+1,y+int hr/2,int hr/2,1,color) # left
  img.drawLine(x+1,y+hr,1,wr,color) # bottom

proc draw3(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+1,y+1,1,wr,color) # top
  img.drawLine(x+wr,y+1,hr,1,color) # right
  img.drawLine(x+1,y+int hr/2,1,wr,color) # middle
  img.drawLine(x+1,y+hr,1,wr,color) # bottom


proc draw4(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+wr-1,y+1,int hr,1,color) # right
  img.drawLine(x+1,y+1+int hr/2,1,wr,color) # middle
  img.drawLine(x+1,y+1,1+int hr/2,1,color) # left

proc draw5(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+1,y+1,1,wr,color) # top
  img.drawLine(x+wr,y+int hr/2,int hr/2,1,color) # right
  img.drawLine(x+1,y+int hr/2,1,wr,color) # middle
  img.drawLine(x+1,y+1,int hr/2,1,color) # left
  img.drawLine(x+1,y+hr,1,wr,color) # bottom

proc draw6(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+1,y+1,1,wr,color) # top
  img.drawLine(x+wr,y+int hr/2,int hr/2,1,color) # right
  img.drawLine(x+1,y+int hr/2,1,wr,color) # middle
  img.drawLine(x+1,y+1,hr,1,color) # left
  img.drawLine(x+1,y+hr,1,wr,color) # bottom

proc draw7(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-2
  img.drawLine(x+1,y+1,1,wr,color) # top
  img.drawLine(x+wr,y+1, int hr/2,1,color) # right
  img.drawLine(x+wr,y+int hr/2,int hr/2,1,color) # right2
  img.drawRevLine(x+wr+1,y+int hr/2,1,2+int wr/2,color) # middle

proc draw8(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+1,y+1,1,wr,color) # top
  img.drawLine(x+wr,y+1,hr,1,color) # right
  img.drawLine(x+1,y+int hr/2,1,wr,color) # middle
  img.drawLine(x+1,y+1,hr,1,color) # left
  img.drawLine(x+1,y+hr,1,wr,color) # bottom

proc draw9(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+1,y+1,1,wr,color) # top
  img.drawLine(x+wr,y+1,hr,1,color) # right
  img.drawLine(x+1,y+int hr/2,1,wr,color) # middle
  img.drawLine(x+1,y+1,int hr/2,1,color) # left
  img.drawLine(x+1,y+hr,1,wr,color) # bottom

proc drawEq*(img: var Image,eq:string, x,y:int=0,color:NColor=Black,ptsize:int=14,dist:int=8) =
  ## TODO: draw ? , x, !, y, handle ptize correctly
  ## Draws an eq supplied as a string.
  ## Currently handles spaces, numbers, `+`, `=`
  for i,c in eq:
    case c:
    of ' ': continue
    of '+': img.drawplus(i*dist,0,color)
    of '=': img.drawequal(i*dist,0,color)
    of '0': img.draw0(i*dist,0,color) 
    of '1': img.draw1(i*dist,0,color)
    of '2': img.draw2(i*dist,0,color)
    of '3': img.draw3(i*dist,0,color)
    of '4': img.draw4(i*dist,0,color)
    of '5': img.draw5(i*dist,0,color)
    of '6': img.draw6(i*dist,0,color)
    of '7': img.draw7(i*dist,0,color)
    of '8': img.draw8(i*dist,0,color)
    of '9': img.draw9(i*dist,0,color)
    else:
      echo "[Nixel]drawEq: Skipping '",c, "', unhandled char"

proc drawCaptcha*(filename,text:string,textColor:NColor=NColor(0x9800FFFF),bgColor:NColor=Transparent,borderColor:NColor=Transparent) =
  ## This function is for nimforum.
  ## Draws text to filename, with oblique lines.
  ## If bgColor is not Transparent the background gets cleared to bgColor
  ## If borderColor is not Transparent a 1px border is drawn.

  var surface = createImage(10*text.len,10)

  if bgColor==Transparent: discard
  else: surface.fillWith(bgColor)
  
  if borderColor==Transparent: discard
  else: surface.drawRect(0,0,surface.width,surface.height,1,borderColor)
  
  # Background Os
  for i in 0..text.len-1:
    surface.drawObliqueLine(i*10,0,2,7,NColor(0xFFFF0099))
    #surface.drawRect(i*5,1,8,8,1,) #Yellow 0
  
  surface.drawEq(text,0,0,textColor,14,10)
  
  surface.saveImageTo(filename)

when isMainModule:
  proc main() =
    #let w = 120
    #let h = 10
  #  let ps = 14
    #var img1 = createImage(w, h)
    #img1.fillWith(White)
    #img1.drawEq("104+132 = ")
    
    #var out1 = newFileStream("testdraw.png", fmWrite)
    #img1.savePng(out1)
    #out1.close()
    #echo("Drew to: testdraw.png")

    drawCaptcha("testdraw.png","104+132=")
  
  main()