import ../nixel

proc createCaptcha*(filename,text:string) = nixel.drawCaptcha(filename,text)

createCaptcha("captcha.png","12+33=")
createCaptcha("captchaBorder.png","12+33=",Red)