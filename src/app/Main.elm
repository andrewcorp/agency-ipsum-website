module Main exposing (..)

import Html exposing (Html, div, h1, h2, img, button, label, text)
import Html.Attributes exposing (class, src, style, width, height)
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
        [ div [class "logo"]
          [ h1 [class "display logo__text"] [text "Agency Ipsum"]
          , img [class "logo__img", src "images/coffee-cup.svg", width 70, height 70] []
        ]
        , h2 [class "subheading"] [text subheading]
        , div [class "form"]
        [ label [class "form__label"] [text "I want 3 paragraphs between 5 and 7 sentences long"]
          , button [ class "button", onClick GenerateIpsum ] [text "New ipsum"]
        ]
      ]
    ]
