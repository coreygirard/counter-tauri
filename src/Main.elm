port module Main exposing (main)

import Browser exposing (Document)
import Element exposing (column)
import Element.Input as Input
import Html exposing (Html, button, div, span, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Json.Decode
import Json.Encode


main : Program () Model Msg
main =
    Browser.document
        { init = \_ -> ( { staging = "", processed = Nothing }, Cmd.none )
        , subscriptions = \_ -> receiveMessage (Json.Decode.decodeValue valueDecoder >> Received)
        , update = update
        , view = view
        }


port sendMessage : String -> Cmd msg


port receiveMessage : (Json.Decode.Value -> msg) -> Sub msg


valueDecoder : Json.Decode.Decoder String
valueDecoder =
    Json.Decode.field "value" Json.Decode.string


type alias Model =
    { staging : String
    , processed : Maybe String
    }


type Msg
    = UpdateString String
    | SendString
    | Received (Result Json.Decode.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateString s ->
            ( { model | staging = s }, Cmd.none )

        SendString ->
            ( model, sendMessage model.staging )

        Received (Ok s) ->
            ( { model | processed = Just s }, Cmd.none )

        Received (Err err) ->
            ( { model | processed = Just <| Json.Decode.errorToString err }, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "Blah"
    , body =
        [ Element.layout [] <|
            column
                []
                [ Input.text []
                    { label = Input.labelHidden ""
                    , onChange = UpdateString
                    , placeholder = Nothing
                    , text = model.staging
                    }
                , Input.button [] { label = Element.text "Send", onPress = Just SendString }
                , Element.text <| Maybe.withDefault "[none]" model.processed
                ]
        ]
    }
