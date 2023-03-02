module Main exposing (main)

import Browser
import Html exposing (Html, button, div, span, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = { n = 0 }, update = update, view = view }


type alias Model =
    { n : Int }


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | n = model.n + 1 }

        Decrement ->
            { model | n = model.n - 1 }


view : Model -> Html Msg
view model =
    div [ style "padding" "48px" ]
        [ button (onClick Decrement :: buttonStyle) [ text "-" ]
        , div displayStyle [ text (String.fromInt model.n) ]
        , button (onClick Increment :: buttonStyle) [ text "+" ]
        ]


displayStyle : List (Html.Attribute msg)
displayStyle =
    [ style "background-color" "#999"
    , style "width" "80px"
    , style "color" "#fff"
    , style "text-align" "center"
    ]


buttonStyle : List (Html.Attribute msg)
buttonStyle =
    [ style "background-color" "#444"
    , style "width" "80px"
    , style "color" "#fff"
    ]
