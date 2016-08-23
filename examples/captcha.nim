import ../nixel


proc drawCaptcha(filename,text:string,textColor:NColor=NColor(0x9800FFFF),bgColor:NColor=Transparent,borderColor:NColor=Transparent) =
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
  
  surface.drawEq(text,0,0,textColor,14,10)
  
  surface.saveImageTo(filename)

proc createCaptcha(filename,text:string,opts:varargs[NColor]) =
  case opts.len:
  of 1: drawCaptcha(filename,text,opts[0])
  of 2: drawCaptcha(filename,text,opts[0],opts[1])
  of 3: drawCaptcha(filename,text,opts[0],opts[1],opts[2])
  else: drawCaptcha(filename,text)

createCaptcha("captcha.png","12+33=")
createCaptcha("captchaBorder.png","12+33=",Purple,Red,White)