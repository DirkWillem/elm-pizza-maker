module Utils exposing (..)

import Html exposing (Html, text)
import Debug

-- Type to use for validated values
type Validated a
  = Pristine a
  | Valid a
  | Invalid a String

-- Validated helper functions
validatedValue : Validated a -> a
validatedValue a =
  case a of
    Valid val ->
      val
    Invalid val _ ->
      val
    Pristine val ->
      val

isValid : Validated a -> Bool
isValid a =
  case a of
    Pristine _ ->
      False
    Valid _ ->
      True
    Invalid _ _ ->
      False

isInvalid : Validated a -> Bool
isInvalid a =
  case a of
    Pristine _ ->
      False
    Valid _ ->
      False
    Invalid _ _ ->
      True

invalidReason : Validated a -> String
invalidReason a =
  case a of
    Pristine _ ->
      "Value has not been set"
    Valid _ ->
      ""
    Invalid _ reason ->
      reason

-- Several often-used validators
notEmptyString : String -> String -> Validated String
notEmptyString value errMsg =
  if (String.length value) > 0 then
    Valid value
  else
    Invalid value errMsg

notEmptyList : List a -> String -> Validated (List a)
notEmptyList value errMsg =
  if (List.length value) > 0 then
    Valid value
  else
    Invalid value errMsg

-- Conditional showing of a piece of HTML
viewIf : Bool -> Html msg -> Html msg
viewIf show content =
  if show then
    content
  else
    text ""