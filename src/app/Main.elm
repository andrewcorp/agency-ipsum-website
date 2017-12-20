port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, height, src, style, width)
import Html.Events exposing (onClick)
import Random exposing (Generator, generate, initialSeed, int)
import String exposing (concat)


-- TODO: Dynamically generate the subheading text
-- TODO: Dynamically generate button text (innovate, disrupt, synergise, go viral, surprise and delight)
-- PORTS


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { intro : String
    , buttonText : String
    , paragraphs : Int
    , sentenceMin : Int
    , sentenceMax : Int
    , backgroundId : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { intro = "Generating dummy text that engages dark social to make the logo bigger"
      , buttonText = "Surprise and delight"
      , paragraphs = 4
      , sentenceMin = 3
      , sentenceMax = 2
      , backgroundId = 1
      }
    , Cmd.batch
        [ backgroundCmd
        ]
    )


backgroundIdGenerator : Generator Int
backgroundIdGenerator =
    int 1 8


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
    | ChangeIntro
    | NewIntro String


type Quantity
    = Paragraphs
    | SentenceMin
    | SentenceMax


type alias Params =
    { paragraphs : Int
    , sentenceMin : Int
    , sentenceMax : Int
    }


port changeIntro : Params -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateIpsum ->
            ( { model | intro = "New value" }, Cmd.none )

        Increment quantity ->
            ( setQuantity model quantity (getQuantity model quantity + 1), Cmd.none )

        Decrement quantity ->
            ( setQuantity model quantity (getQuantity model quantity - 1), Cmd.none )

        ChangeBackground ->
            ( model, backgroundCmd )

        NewBackgroundId id ->
            ( { model | backgroundId = id }, Cmd.none )

        ChangeIntro ->
            ( model, changeIntro { paragraphs = 1, sentenceMin = 1, sentenceMax = 1 } )

        NewIntro str ->
            ( { model | intro = str }, Cmd.none )


getQuantity : Model -> Quantity -> Int
getQuantity model quantity =
    case quantity of
        Paragraphs ->
            model.paragraphs

        SentenceMin ->
            model.sentenceMin

        SentenceMax ->
            model.sentenceMax


setQuantity : Model -> Quantity -> Int -> Model
setQuantity model quantity value =
    if value < 1 then
        model
    else
        case quantity of
            Paragraphs ->
                { model | paragraphs = value }

            SentenceMin ->
                { model | sentenceMin = value }

            SentenceMax ->
                { model | sentenceMax = value }


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



-- SUBSCRIPTIONS


port ipsum : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    ipsum NewIntro



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
                , row "with at least" model.sentenceMin "but no more" SentenceMin
                , row "than" model.sentenceMax "sentences." SentenceMax
                , div [ class "form__row" ]
                    [ button [ class "button form__button", onClick ChangeIntro ] [ text "Surprise and delight" ] ]
                ]
            ]
        ]
