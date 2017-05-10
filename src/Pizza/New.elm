module Pizza.New exposing (..)

import Html exposing (Html, a, text, div, button, i)
import Html.Attributes exposing (class, disabled)
import Html.Events exposing (onClick)
import Models exposing (Model, Topping, NewPizza)
import Msgs exposing (Msg)
import Utils exposing (Validated, validatedValue, isValid)
import Controls exposing (..)

view : Model -> Html Msg
view model =
  div [class "new-pizza"]
    [ toppings model
    , pizzaForm model.newPizza
    , pizzaFormButtons model.newPizza
    ]

-- Toppings selector
toppings : Model -> Html Msg
toppings model =
  div [class "toppings"]
    ((model.toppings
      |> List.map (toppingItem model)) ++
      [ validationError model.newPizza.toppings
      ])


toppingItem : Model -> Topping -> Html Msg
toppingItem model topping =
  let
    added =
      model.newPizza.toppings
        |> validatedValue
        |> List.any (\addedTopping -> addedTopping == topping)
  in
    toppingBtn topping added


toppingBtn : Topping -> Bool -> Html Msg
toppingBtn topping added =
  let
    clickMsg =
      if added then
        Msgs.RemoveTopping
      else
        Msgs.AddTopping

    className =
      if added then
        "topping added"
      else
        "topping"
  in
    a [ class className, onClick (clickMsg topping) ]
        [ text topping ]

-- Pizza form
pizzaForm : NewPizza -> Html Msg
pizzaForm pizza =
  div [class "pizza-form"]
    [ validatedTextInput pizza.name "Enter a name for your pizza" Msgs.ChangeName
    , appliedToppings pizza
    ]

-- Pizza toppings
appliedToppings : NewPizza -> Html Msg
appliedToppings pizza =
  let
    ts =
      pizza.toppings
        |> validatedValue

    hasToppings =
      (List.length (validatedValue pizza.toppings)) > 0
  in
    div [class "selected-toppings" ]
      (if hasToppings then
        [ div [class "list"]
          (List.map topping ts)
        ]
      else
        [ div [class "empty" ] [ text "No toppings selected" ] ])

topping : Topping -> Html Msg
topping t =
  div [ class "item" ]
  [ text t
  , button [class "fa fa-times", onClick (Msgs.RemoveTopping t)] []
  ]

-- Pizza form buttons
pizzaFormButtons : NewPizza -> Html Msg
pizzaFormButtons pizza =
  let
    isInvalid =
      (not (isValid pizza.name)) || (not (isValid pizza.toppings))
  in
    div [ class "pizza-form-buttons" ]
      [ button [ class "btn", disabled isInvalid ]
        [ i [class "fa fa-plus-circle"] []
        , text "Create Pizza"
        ]
      ]