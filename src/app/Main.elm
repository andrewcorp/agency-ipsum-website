port module Main exposing (..)

import Array exposing (fromList, get)
import Html exposing (..)
import Html.Attributes exposing (id, class, height, src, style, width)
import Html.Events exposing (onClick)
import Maybe exposing (withDefault)
import Random exposing (Generator, generate, initialSeed, int)
import String exposing (concat)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- PORTS


type alias Params =
    { paragraphs : Int
    , sentenceMin : Int
    , sentenceMax : Int
    }


port generateIntro : Params -> Cmd msg


port generateIpsum : Params -> Cmd msg


port copyText : () -> Cmd msg


-- SUBSCRIPTIONS


port newIntro : (String -> msg) -> Sub msg


port newIpsum : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ newIntro NewIntro
        , newIpsum NewIpsum
        ]



-- MODEL


type alias Model =
    { intro : Maybe String
    , ipsum : Maybe String
    , paragraphs : Int
    , sentenceMin : Int
    , sentenceMax : Int
    , backgroundId : Int
    , buttonTextId : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { intro = Nothing
      , ipsum = Nothing
      , paragraphs = 4
      , sentenceMin = 5
      , sentenceMax = 6
      , backgroundId = 1
      , buttonTextId = 0
      }
    , Cmd.batch
        [ generateBackground
        , generate NewButtonTextId (int 0 4)
        , generateIntro { paragraphs = 1, sentenceMin = 1, sentenceMax = 1 }
        ]
    )



-- COMMANDS


generateBackground : Cmd Msg
generateBackground =
    generate NewBackgroundId (int 1 10)



-- UPDATE


type Msg
    = Ipsum
    | NewIpsum String
    | Increment Quantity
    | Decrement Quantity
    | CopyText
    | ChangeBackground
    | NewBackgroundId Int
    | NewButtonTextId Int
    | NewIntro String
    | ClearIpsum


type Quantity
    = Paragraphs
    | SentenceMin
    | SentenceMax


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Ipsum ->
            ( model, generateIpsum { paragraphs = model.paragraphs, sentenceMin = model.sentenceMin, sentenceMax = model.sentenceMax } )

        NewIpsum str ->
            ( { model | ipsum = Just str }, Cmd.none )

        Increment quantity ->
            ( setQuantity model quantity (getQuantity model quantity + 1), Cmd.none )

        Decrement quantity ->
            ( setQuantity model quantity (getQuantity model quantity - 1), Cmd.none )

        CopyText ->
            ( model, copyText ())

        ChangeBackground ->
            ( model, generateBackground )

        NewBackgroundId id ->
            ( { model | backgroundId = id }, Cmd.none )

        NewButtonTextId id ->
            ( { model | buttonTextId = id }, Cmd.none )

        NewIntro str ->
            ( { model | intro = Just str }, Cmd.none )

        ClearIpsum ->
            ( { model | ipsum = Nothing }, Cmd.none )


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



-- VIEWS


renderModal : Model -> Html Msg
renderModal model =
    case model.ipsum of
        Nothing ->
            text ""

        Just ipsum ->
            div [ class "modal" ]
                [ pre [ id "ipsum-text", class "body" ] [ text (withDefault "" model.ipsum) ]
                , button [ class "modal__close", onClick ClearIpsum ] [ text "clear" ]
                , button [ class "button modal__button", onClick CopyText ] [ text "Copy to clipboard" ]
                ]


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
            , h2 [ class "subheading" ] [ text (withDefault "" model.intro) ]
            , div [ class "form" ]
                [ row "I want" model.paragraphs "paragraphs" Paragraphs
                , row "with at least" model.sentenceMin "but no more" SentenceMin
                , row "than" model.sentenceMax "sentences." SentenceMax
                , div [ class "form__row" ]
                    [ button [ class "button form__button", onClick Ipsum ] [ buttonText model ] ]
                ]
            , renderModal model
            ]
        ]


buttonText : Model -> Html Msg
buttonText model =
    let
        labelArray =
            Array.fromList [ "Innovate", "Disrupt", "Synergise", "Go viral", "Surprise and delight" ]

        selectedLabel =
            Array.get model.buttonTextId labelArray
    in
    text (withDefault "" selectedLabel)
