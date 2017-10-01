module Main exposing (..)

import Html exposing (Html, div, h1, h2, img, button, label, span, text)
import Html.Attributes exposing (class, src, style, width, height)
import Html.Events exposing (onClick)

-- TODO: Dynamically generate the subheading text
-- TODO: Dynamically generate button text (innovate, disrupt, synergise, go viral)
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
  div [class "wrapper", style [("background-image", "url('images/background-1.jpg')")]]
    [ div [class "overlay"] []
    , div [class "container"]
        [ div [class "logo"]
          [ h1 [class "display logo__text"] [text "Agency Ipsum"]
          , img [class "logo__img", src "images/coffee-cup.svg", width 70, height 70] []
        ]
        , h2 [class "subheading"] [text subheading]
        , div [class "form"]
          [ div [class "form__row"]
            [ label [class "form__label"] [text "I want"]
            , div [class "form__input-wrap"]
              [ span [class "form__input"] [text "3"]
              , div [class "form__toggle"]
              [ span [class "form__toggle-up"] []
              , span [class "form__toggle-down"] []
              ]
            ]
            , label [class "form__label"] [text "paragraphs"]
            ]
          , div [class "form__row"]
            [ label [class "form__label"] [text "with at least"]
            , div [class "form__input-wrap"]
              [ span [class "form__input"] [text "5"]
              , div [class "form__toggle"]
              [ span [class "form__toggle-up"] []
              , span [class "form__toggle-down"] []
              ]
            ]
            , label [class "form__label"] [text "sentences"]
            ]
          , div [class "form__row"]
            [ label [class "form__label"] [text "and no more than"]
            , div [class "form__input-wrap"]
              [ span [class "form__input"] [text "7"]
              , div [class "form__toggle"]
              [ span [class "form__toggle-up"] []
              , span [class "form__toggle-down"] []
              ]
            ]
          ]
          , div [class "form__row"]
            [ button [ class "button form__button", onClick GenerateIpsum ] [text "Surprise and delight"] ]
          ]
       ]
    ]
