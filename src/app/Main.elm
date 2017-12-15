module Main exposing (..)

import Random exposing (Generator, int, initialSeed, generate)
import String exposing (concat)

import Html exposing (Html, button, div, h1, h2, img, label, span, text)
import Html.Attributes exposing (class, height, src, style, width)
import Html.Events exposing (onClick)


-- TODO: Dynamically generate the subheading text
-- TODO: Dynamically generate button text (innovate, disrupt, synergise, go viral, surprise and delight)


main =
     Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- Model


type alias Model =
    { intro : String
    , buttonText : String
    , paragraphs : Int
    , sentencesMin : Int
    , sentencesMax : Int
    , backgroundId : Int
    }


init : (Model, Cmd Msg)
init =
    ({ intro = "Generating dummy text that engages dark social to make the logo bigger"
     , buttonText = "Surprise and delight"
     , paragraphs = 4
     , sentencesMin = 3
     , sentencesMax = 2
     , backgroundId = 1
     }
     , backgroundCmd
    )

backgroundIdGenerator : Generator Int
backgroundIdGenerator = int 1 8

backgroundCmd : Cmd Msg
backgroundCmd =
  generate NewBackgroundId backgroundIdGenerator

-- Update

type Msg
    = GenerateIpsum
    | Increment Quantity
    | Decrement Quantity
    | ChangeBackground
    | NewBackgroundId Int

type Quantity
    = Paragraphs
    | SentencesMin
    | SentencesMax

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateIpsum ->
            ({ model | intro = "New value" }, Cmd.none)
        Increment quantity ->
            (setQuantity model quantity ((getQuantity model quantity) + 1), Cmd.none)
        Decrement quantity ->
            (setQuantity model quantity ((getQuantity model quantity) - 1), Cmd.none)
        ChangeBackground ->
            (model, backgroundCmd)
        NewBackgroundId id ->
            ({ model | backgroundId = id }, Cmd.none)


getQuantity : Model -> Quantity -> Int
getQuantity model quantity =
    case quantity of
      Paragraphs ->
        model.paragraphs
      SentencesMin ->
        model.sentencesMin
      SentencesMax ->
        model.sentencesMax


setQuantity : Model -> Quantity -> Int -> Model
setQuantity model quantity value =
    if value < 1 then
      model
    else
      case quantity of
        Paragraphs ->
          { model | paragraphs = value }
        SentencesMin ->
          { model | sentencesMin = value }
        SentencesMax ->
          { model | sentencesMax = value }


row : String -> Int -> String -> Quantity -> Html Msg
row label1 value label2 quantity =
    div [ class "form__row" ]
        [ label [ class "form__label" ] [ text label1 ]
        , div [ class "form__input-wrap" ]
            [ span [ class "form__input" ] [ text (toString value) ]
            , div [ class "form__toggle" ]
                [ span [ class "form__toggle-up", onClick (Increment quantity) ] []
                , span [ class "form__toggle-down", onClick (Decrement quantity) ] []
                ]
            ]
        , label [ class "form__label" ] [ text label2 ]
        ]


-- View


view : Model -> Html Msg
view model =
    div [ class "wrapper", style [ ( "background-image", concat [ "url('images/background-", toString model.backgroundId, ".jpg')" ] ) ] ]
        [ div [ class "overlay" ] []
        , div [ class "container" ]
            [ div [ class "logo" ]
                [ div [ class "logo__wrap" ]
                    [ img [ class "logo__img", src "images/coffee-cup.svg", width 55, height 55 ] []
                    ]
                , h1 [ class "display logo__text" ] [ text "Agency Ipsum" ]
                ]
            , h2 [ class "subheading" ] [ text model.intro ]
            , div [ class "form" ]
                [ row "I want" model.paragraphs "paragraphs" Paragraphs
                , row "with at least" model.sentencesMin "but no more" SentencesMin
                , row "than" model.sentencesMax "sentences." SentencesMax
                , div [ class "form__row" ]
                    [ button [ class "button form__button", onClick ChangeBackground ] [ text "Surprise and delight" ] ]
                ]
            ]
        ]
