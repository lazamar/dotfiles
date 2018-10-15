import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

-- Mod4 is the Super / Windows key
myModMask = mod4Mask
altMask = mod1Mask

main = do
        xmproc <- spawnPipe "xmobar ~/.xmobarrc.hs"
        xmonad $ defaultConfig
           { manageHook = manageDocks <+> manageHook defaultConfig
           , layoutHook = avoidStruts  $  layoutHook defaultConfig
           , logHook = dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "#2196F3" "" . shorten 50
                }
           , terminal = "urxvt"
           , focusedBorderColor = "#2196F3"
           } `additionalKeys`
           [ -- Kill windows with Alt-F4
            ((altMask, xK_F4 ), kill)
           ,((altMask, xK_b  ), sendMessage ToggleStruts)
           ] 
