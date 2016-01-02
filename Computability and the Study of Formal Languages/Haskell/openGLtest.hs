import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT
 
main :: IO ()
main = do
  (progname, _) <- getArgsAndInitialize
  createWindow "Render Test"
  displayCallback $= display
  mainLoop
 
display :: IO ()
display = do
  clear [ ColorBuffer ]
  flush
