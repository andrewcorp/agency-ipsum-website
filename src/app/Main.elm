module Main exposing (..)

import Html exposing (Html, button, div, h1, h2, img, label, span, text)
import Html.Attributes exposing (class, height, src, style, width)
import Html.Events exposing (onClick)


-- TODO: Dynamically generate the subheading text
-- TODO: Dynamically generate button text (innovate, disrupt, synergise, go viral)


main =
    Html.beginnerProgram { model = init, view = view, update = update }



-- Model


type alias Model =
    { intro : String
    , buttonText : String
    , paragraphsMin : Int
    , paragraphsMax : Int
    , sentences : Int
    }


init : Model
init =
    { intro = "Generating dummy text that engages dark social to make the logo bigger"
    , buttonText = "Surprise and delight"
    , paragraphsMin = 4
    , paragraphsMax = 3
    , sentences = 2
    }



-- Update


type Msg
    = GenerateIpsum


update : Msg -> Model -> Model
update msg model =
    case msg of
        GenerateIpsum ->
            { model | intro = "New value" }


row : String -> Int -> String -> Html Msg
row label1 qty label2 =
    div [ class "form__row" ]
        [ label [ class "form__label" ] [ text label1 ]
        , div [ class "form__input-wrap" ]
            [ span [ class "form__input" ] [ text (toString qty) ]
            , div [ class "form__toggle" ]
                [ span [ class "form__toggle-up" ] []
                , span [ class "form__toggle-down" ] []
                ]
            ]
        , label [ class "form__label" ] [ text label2 ]
        ]



-- View


view : Model -> Html Msg
view model =
    div [ class "wrapper", style [ ( "background-image", "url('images/background-6.jpg')" ) ] ]
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
                [ row "I want" model.paragraphsMin "paragraphs"
                , row "with at least" model.paragraphsMax "but no more"
                , row "than" model.sentences "sentences."
                , div [ class "form__row" ]
                    [ button [ class "button form__button", onClick GenerateIpsum ] [ text "Surprise and delight" ] ]
                ]
            ]
        ]
