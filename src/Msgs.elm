module Msgs exposing (..)

import Models exposing (Topping)

-- Message types
type Msg
  = ChangeName String
  | AddTopping Topping
  | RemoveTopping Topping