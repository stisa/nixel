import ../nixel

proc createCaptcha*(filename,text:string,opts:varargs[NColor]) =
  case opts.len:
  of 1: nixel.drawCaptcha(filename,text,opts[0])
  of 2: nixel.drawCaptcha(filename,text,opts[0],opts[1])
  of 3: nixel.drawCaptcha(filename,text,opts[0],opts[1],opts[2])
  else: nixel.drawCaptcha(filename,text)

createCaptcha("captcha.png","12+33=")
createCaptcha("captchaBorder.png","12+33=",Purple,Red,White)