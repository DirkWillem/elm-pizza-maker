module View exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Models exposing (Model)
import Msgs exposing (Msg)
import Pizza.New

view : Model -> Html Msg
view model =
  div [ class "app-container" ]
    [ div [class "app" ]
      [ Pizza.New.view model
      ]
    ]