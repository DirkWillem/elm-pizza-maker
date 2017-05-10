module Models exposing (..)

import Utils exposing (Validated(..))

-- Model type
type alias Model =
  { newPizza : NewPizza
  , toppings : List Topping
  }

-- Pizza model
type alias Topping =
  String

type alias NewPizza =
  { name: Validated String
  , toppings : Validated (List Topping)
  }

-- Initial model value
initialModel : Model
initialModel =
  { newPizza = NewPizza (Pristine "") (Pristine [])
  , toppings = [ "Bacon", "Pepperoni", "Mushrooms", "Herbs", "Chicken", "Pineapple", "Ham", "Jalapenos" ]
  }