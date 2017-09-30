module Main exposing (..)

import Html exposing (Html, div, h1, h2, button, text)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)

-- TODO: Dynamically generate the subheading text
main =
  Html.beginnerProgram { model = subheading, view = view, update = update }

-- Model

type alias Subheading = String

subheading : Subheading
subheading =
  "Generating dummy text that engages dark social to make the logo bigger"

-- Update

type Ipsum = GenerateIpsum

update: Ipsum -> Subheading -> Subheading
update msg subheading =
  case msg of
    GenerateIpsum ->
      "this is a new string"

-- View

view : Subheading -> Html Ipsum
view subheading =
  div [class "wrapper", style [("background-image", "url('images/background-6.jpg')")]]
    [ div [class "overlay"] []
    , div [class "container"]
        [ h1 [class "display"] [text "Agency Ipsum"]
        , h2 [class "subheading"] [text subheading]
        , button [ onClick GenerateIpsum ] [text "New ipsum"]
      ]
    ]
