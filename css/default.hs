{-# LANGUAGE OverloadedStrings #-}
import           Prelude hiding (div,(**))
import           Data.Monoid
import qualified Data.Text.Lazy.IO as L
import           Clay
import qualified Clay.Display

reallyDarkPurple, darkererPurple, darkerPurple, darkPurple, ourPurple, rose :: Color
reallyDarkPurple = other "#170b1a"
darkererPurple   = other "#1e1420"
darkerPurple     = other "#211024"
darkPurple       = other "#2d1630"
ourPurple        = other "#452d49"
rose             = other "#be83c6"

bodyCss :: Css
bodyCss = body ? do
  color white
  backgroundColor darkPurple
  background $ linearGradient (angular $ deg 180)
    [ (reallyDarkPurple, 0)
    , (darkerPurple, 5)
    , (darkPurple, 30)
    ]
  --backgroundRepeat noRepeat
  backgroundAttachment attachFixed
  fontSize (px 15)
  lineHeight (px 24)
  fontWeight lighter
  "font-family" -: "Ubuntu, sans-serif"
  sym margin nil
  width (other "100%")

layoutCss :: Css
layoutCss = do
  (header <> main_ <> (footer # ".footer")) ? do
    width (px 660)
    sym2 margin nil auto
  main_ ?
    sym padding (px 30)
    --backgroundColor darkererPurple
  div # ".block" ? do
    paddingTop (px 0)
    paddingLeft (px 20)
    paddingRight (px 20)
    paddingBottom (px 10)
    border solid (px 10) darkererPurple
    marginBottom (px 20)
    background reallyDarkPurple
    color white
    -- http://nicolasgallagher.com/micro-clearfix-hack/
    ":after" <> ":before" ? do
      content (stringContent " ")
      display Clay.Display.table
    ":after" ?
      clear both
  div # ".block.bright" ? do
    backgroundColor (other "#dddddd")
    color (other "#222")
  header ? do
    marginTop (px 10)
    marginBottom (px 30)
    sym2 padding (px 12) nil
    position relative
    div # "#logo" ? do
      width (px 320)
      float floatLeft
    blockquote ? do
      sym margin nil
      paddingRight (px 40)
      textAlign end
      width (px 150)
      float floatRight
      p ? sym margin nil
      footer ? do
        color rose
        borderTopStyle none
        marginTop nil
        paddingTop (px 6)
        marginLeft (em 2)
  -- based on http://www.cssstickyfooter.com
  div # ".wrap" ?
    minHeight (other "100%")
  div # ".main" ? do
    overflow auto
    paddingBottom (px 50)
  html <> body ? height (other "100%")
  footer # ".footer" ? do
    borderTop dashed (px 1) rose
    color rose
    fontSize (px 12)
    position relative
    marginTop (px (-45))
    sym2 padding (px 10) nil
    textAlign end

contentCss :: Css
contentCss = do
  star # ".clear" ?
    clear both
  h1 <> h2 <> h3 ? do
    margin (em 1) nil (em 0.5) nil
    fontWeight normal
  h2 ?
    fontSize (px 20)
  "h2:before" ? do
    fontWeight bold
    content (stringContent "λ")
    paddingRight (px 10)
    color ourPurple
  ((a # link) <> (a # visited)) ?
    color rose
  div # ".block.bright" ?
    ((a # link) <> (a # visited)) ?
      color ourPurple
  p # "#next-meeting" ? do
    fontSize (px 18)
    textAlign (alignSide sideCenter)
  div # ".abstract" ?
    fontStyle italic
  address ?
    float floatLeft
  div # "#map" ? do
    float floatRight
    height (px 220)
    width (px 400)
    border solid (px 5) ourPurple
    marginBottom (px 15)
    --sym2 margin (px 15) nil
  div # "#info" ? do
    color (other "#555")
    fontSize (px 14)
    fontStyle italic
  pre # ".error-404" ? do
    fontFamily ["Ubuntu Mono"] [monospace,sansSerif]
    fontSize (px 40)
    lineHeight (px 64)

main :: IO ()
main = L.putStr $ render $ do
  importUrl "/css/ubuntu.css"
  bodyCss
  layoutCss
  contentCss
