module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Char exposing (isDigit, isUpper, isLower)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }


init : Model
init =
  Model "" "" ""



-- UPDATE


type Msg
  = Name String
  | Password String
  | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
  div [ style "height" "auto", style "width" "auto", style "text-align" "center" ]
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , viewValidation model
    , div [ style "color" "black" ] [ text "Password must be at least 8 characters long and contain 1 Upper, 1 Lower, 1 digit" ] 
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
  if not (String.length model.password >= 8) then div [ style "color" "red" ] [ text "Password complexity not met!" ]
  else if not (String.any isDigit model.password) then div [ style "color" "red" ] [ text "Password complexity not met!" ]
  else if not (String.any isUpper model.password) then div [ style "color" "red" ] [ text "Password complexity not met!" ]
  else if not (String.any isLower model.password) then div [ style "color" "red" ] [ text "Password complexity not met!" ]
  else if not (model.password == model.passwordAgain) then div [ style "color" "red" ] [ text "Passwords do not match!" ]
  else
    div [ style "color" "green" ] [ text "Ok!" ]