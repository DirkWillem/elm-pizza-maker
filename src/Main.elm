module Main exposing (..)

import Html exposing (program, text)
import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import View exposing (view)
import Update exposing (update)

-- Initial values
init : (Model, Cmd Msg)
init =
  (initialModel, Cmd.none)

-- Subscriptions
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- Main program
main =
  program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }