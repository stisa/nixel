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
  White* = NColor(0xFFFFFFFF)
  
  
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

proc drawObliqueLine(img: var Image, x,y:int=0, thickness :int= 1,length:int=1,color:NColor=Black ) =
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

#[]
proc drawA(img:var Image,x,y:int=0,ptsize:int=14,color:NColor=Black)=
  img.drawRect(x+1,y+1,int ptsize/2,int ptsize/2-2)
  img.drawLine(x+1,y+1,int ptsize/2+1,1)
  img.drawLine(x+int ptsize/2,y+1,int ptsize/2+1,1)

proc drawB(img:var Image,x,y:int=0,ptsize:int=14,color:NColor=Black)=
  img.drawRect(x+1,y+1,int ptsize/2-1,int (1+ptsize/4) )
  img.drawRect(x+1,y+int (1+ptsize/4),int ptsize/2,int 1+ptsize/4)

proc drawC(img:var Image,x,y:int=0,ptsize:int=14,color:NColor=Black)=
  let 
    height = 1+int ptsize/2
    width = int ptsize/2-2
    thickness = 1

  img.drawLine(x+1,y+1,height,thickness) # left side
  img.drawLine(x+1,y+1,thickness,width) # top side
  img.drawRevLine(x+width,y+height,thickness,width) # bottom side ]#


proc drawplus (img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let hr,wr = 5 # hardcoding is a bad idea
  img.drawLine(x+1+int wr/2,y+3,hr,1) # vertical line
  img.drawLine(x+1,y+3+int hr/2,1,wr) #horizontal line

proc drawequal (img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let hr,wr = 5 # hardcoding is a bad idea
  img.drawLine(x+1,y+4,1,wr) # vertical line
  img.drawLine(x+1,y+4+int hr/2,1,wr) #horizontal line

proc draw0 (img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let
    hr = int ptsize/2 + 1
    wr = int ptsize/2 - 1 
  img.drawRect(x+int wr/2,y+int hr/2,2,2) # dot inside the 0 
  img.drawRect(x+1,y+1,wr,hr)

proc draw1 (img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let
    hr = int ptsize/2 + 1
    wr = int ptsize/2 - 1 
  img.drawLine(x+1+int wr/2,y+1,hr,1) # vertical line
  img.drawLine(x+1,y+hr,1,wr) #horizontal line
  img.drawRevLine(x+int wr/2,y+2,1,1) # oblique line 1/2
  img.drawRevLine(x+int wr/2,y+3,1,2) # oblique line 2/2

proc draw2(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+1,y+1,1,wr) # top
  img.drawLine(x+wr,y+1,int hr/2,1) # right
  img.drawLine(x+1,y+int hr/2,1,wr) # middle
  img.drawLine(x+1,y+int hr/2,int hr/2,1) # left
  img.drawLine(x+1,y+hr,1,wr) # bottom

proc draw3(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+1,y+1,1,wr) # top
  img.drawLine(x+wr,y+1,hr,1) # right
  img.drawLine(x+1,y+int hr/2,1,wr) # middle
  img.drawLine(x+1,y+hr,1,wr) # bottom


proc draw4(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+wr-1,y+1,int hr,1) # right
  img.drawLine(x+1,y+1+int hr/2,1,wr) # middle
  img.drawLine(x+1,y+1,1+int hr/2,1) # left

proc draw5(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+1,y+1,1,wr) # top
  img.drawLine(x+wr,y+int hr/2,int hr/2,1) # right
  img.drawLine(x+1,y+int hr/2,1,wr) # middle
  img.drawLine(x+1,y+1,int hr/2,1) # left
  img.drawLine(x+1,y+hr,1,wr) # bottom

proc draw6(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+1,y+1,1,wr) # top
  img.drawLine(x+wr,y+int hr/2,int hr/2,1) # right
  img.drawLine(x+1,y+int hr/2,1,wr) # middle
  img.drawLine(x+1,y+1,hr,1) # left
  img.drawLine(x+1,y+hr,1,wr) # bottom

proc draw7(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-2
  img.drawLine(x+1,y+1,1,wr) # top
  img.drawLine(x+wr,y+1, int hr/2,1) # right
  img.drawLine(x+wr,y+int hr/2,int hr/2,1) # right2
  img.drawRevLine(x+wr+1,y+int hr/2,1,2+int wr/2) # middle

proc draw8(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+1,y+1,1,wr) # top
  img.drawLine(x+wr,y+1,hr,1) # right
  img.drawLine(x+1,y+int hr/2,1,wr) # middle
  img.drawLine(x+1,y+1,hr,1) # left
  img.drawLine(x+1,y+hr,1,wr) # bottom

proc draw9(img:var Image,x,y:int=0,color:NColor=Black,ptsize:int=14)=
  let 
    hr= 1+int ptsize/2
    wr= int ptsize/2-1
  img.drawLine(x+1,y+1,1,wr) # top
  img.drawLine(x+wr,y+1,hr,1) # right
  img.drawLine(x+1,y+int hr/2,1,wr) # middle
  img.drawLine(x+1,y+1,int hr/2,1) # left
  img.drawLine(x+1,y+hr,1,wr) # bottom

proc drawEq*(img: var Image,eq:string, x,y:int=0,color:NColor=Black,ptsize:int=14) =
  ## TODO: draw ? , x, !, y, handle ptize correctly
  ## Draws an eq supplied as a string.
  ## Currently handles spaces, numbers, `+`, `=`
  for i,c in eq:
    case c:
    of ' ': continue
    of '+': img.drawplus(i*8,0) #TODO color
    of '=': img.drawequal(i*8,0) #TODO color
    of '0': img.draw0(i*8,0) #TODO color
    of '1': img.draw1(i*8,0)
    of '2': img.draw2(i*8,0)
    of '3': img.draw3(i*8,0)
    of '4': img.draw4(i*8,0)
    of '5': img.draw5(i*8,0) #TODO color
    of '6': img.draw6(i*8,0)
    of '7': img.draw7(i*8,0)
    of '8': img.draw8(i*8,0)
    of '9': img.draw9(i*8,0)
    else:
      echo "[NDraw]: '",c, "' can't be drawn"

proc drawCaptcha*(filename,text:string,borderColor:NColor=Transparent) =
  ## This function is for nimforum.
  ## Draws text to filename.
  ## If borderColor is not Transparent a 1px border is drawn.

  #TODO: add half alpha lines to sway bots
  var surface = createImage(10*text.len,10)
  if borderColor==Transparent: discard
  else: surface.drawRect(0,0,surface.width,surface.height,1,borderColor)
  surface.drawEq(text)
  surface.saveImageTo(filename)

when isMainModule:
  proc main() =
    let w = 120
    let h = 120
  #  let ps = 14
    var img1 = createImage(w, h)
    img1.fillWith(White)
    img1.drawObliqueLine(0,0,1,50)    
    #img1.drawEq("104+132 = ")
    
    var out1 = newFileStream("testdraw.png", fmWrite)
    img1.savePng(out1)
    out1.close()
    echo("Drew to: testdraw.png")
  main()