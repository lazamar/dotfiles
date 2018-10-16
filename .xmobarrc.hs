Config 
  { font = "xft:inconsolatalgc:pixelsize=12:antialias=true"
  , bgColor = "#000000"
  , fgColor = "#93a1a1"
  , border = NoBorder
  , borderColor = "black"
  , hideOnStart = False
  , persistent = True
  , allDesktops = True
  , position = Top
  , lowerOnStart = True
  , commands = 
  	[ Run Network "enp4s0" ["-L","0","-H","32","--normal","#657b83","--high","#657b83"] 10
  	, Run Cpu ["-L","3","-H","50","--normal","#657b83","--high","#657b83"] 10
  	, Run Memory ["-t","Mem: <usedratio>%"] 10
    , Run Date "<fc=#93a1a1>%a %b %_d %Y %H:%M</fc>" "date" 10
  	, Run StdinReader
    , Run Battery [
      "-t", "<acstatus>: <left>% - <timeleft>",
      "--",
      --"-c", "charge_full",
      "-O", "AC",
      "-o", "Bat",
      "-h", "green",
      "-l", "red"
      ] 10
    ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = " %StdinReader% }{ %cpu% | %memory% | %battery% | %date%"
}
