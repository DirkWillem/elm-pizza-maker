module Controls exposing (..)

import Html exposing (Html, input, div, text)
import Html.Attributes exposing (class, value, type_, placeholder)
import Html.Events exposing (onInput)
import Utils exposing (Validated(..), viewIf, validatedValue, isInvalid, invalidReason)

-- Validation error
validationError : Validated a -> Html msg
validationError validated =
  viewIf (isInvalid validated) (div [ class "error-message" ]
    [ text (invalidReason validated) ])

-- Text input control
textInput : String -> String -> (String -> msg) -> Html msg
textInput v p msg =
  input [ type_ "text", value v, placeholder p, onInput msg, class "text-input" ] []


-- Text input control for validated values
validatedTextInput : Validated String -> String -> (String -> msg) -> Html msg
validatedTextInput v p msg =
  let
    showError =
      isInvalid v
  in
    div [ class "text-input-container"]
      [ textInput (validatedValue v) p msg
      , validationError v
      ]