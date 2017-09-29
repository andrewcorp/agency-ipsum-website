module Main exposing (..)

import Html exposing (Html, div, h1, h2, text)
import Html.Attributes exposing (class, style)

-- TODO: Dynamically generate the subheading text
main =
  div [class "wrapper", style [("background-image", "url('images/background-6.jpg')")]]
    [ div [class "overlay"] []
    , div [class "container"]
        [ h1 [class "display"] [text "Agency Ipsum"]
        , h2 [class "subheading"] [text "Generating dummy text that engages dark social to make the logo bigger"]
      ]
    ]
