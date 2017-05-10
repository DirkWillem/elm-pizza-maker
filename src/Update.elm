module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model, NewPizza, Topping)
import Utils exposing (Validated(..), notEmptyString, notEmptyList, validatedValue)

-- Update function
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Msgs.ChangeName newName ->
      let
        updatedPizza =
          updateName model.newPizza newName
      in
        ( { model | newPizza = updatedPizza } , Cmd.none )

    Msgs.AddTopping topping ->
      let
        newToppings =
          (validatedValue model.newPizza.toppings) ++ [topping]

        updatedPizza =
          updateToppings model.newPizza newToppings
      in
        ( { model | newPizza = updatedPizza }, Cmd.none )

    Msgs.RemoveTopping removedTopping ->
      let
        newToppings =
          model.newPizza.toppings
            |> validatedValue
            |> List.filter (\topping -> topping /= removedTopping)

        updatedPizza =
          updateToppings model.newPizza newToppings
      in
        ( { model | newPizza = updatedPizza }, Cmd.none )


-- Update helper functions for updating pizza properties
updateName : NewPizza -> String -> NewPizza
updateName pizza name =
    { pizza | name = (notEmptyString name "Your pizza must have a name") }


updateToppings : NewPizza -> List Topping -> NewPizza
updateToppings pizza toppings =
  { pizza | toppings = (notEmptyList toppings "Your pizza must have at least 1 topping") }