{-# LANGUAGE ScopedTypeVariables #-}
import Workbook.Check
import TodoList

fromTodos :: [Int] -> TodoList
fromTodos = foldl add empty

main :: IO ()
main = runChecks
  [ eq "empty has no todos"                  (todos empty) []
  , eq "empty has none completed"            (completed empty) 0
  , eq "add puts a todo at the front"        (todos (add (add empty 1) 2)) [2, 1]
  , eq "add completes nothing"               (completed (add (add empty 1) 2)) 0
  , eq "remove index 0 takes the front"      (todos (remove (fromTodos [1, 2, 3]) 0)) [2, 1]
  , eq "remove index 1 takes the middle"     (todos (remove (fromTodos [1, 2, 3]) 1)) [3, 1]
  , eq "remove index 2 takes the last"       (todos (remove (fromTodos [1, 2, 3]) 2)) [3, 2]
  , eq "remove counts one as completed"      (completed (remove (fromTodos [1, 2, 3]) 1)) 1
  , eq "removing twice counts two"           (completed (remove (remove (fromTodos [1, 2, 3]) 1) 0)) 2
  , eq "add keeps the completed count"       (completed (add (remove (fromTodos [1, 2]) 0) 3)) 1
  , prop "remove behaves like the Python list" $ \(NonEmpty (xs :: [Int])) (NonNegative (k :: Int)) ->
      let i = k `mod` length xs
          list = foldr (flip add) empty xs
       in todos list == xs
            && todos (remove list i) == take i xs ++ drop (i + 1) xs
            && completed (remove list i) == 1
  ]
