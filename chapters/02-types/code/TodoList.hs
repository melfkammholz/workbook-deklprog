module TodoList (TodoList, empty, add, remove, todos, completed) where

#ifdef TEMPLATE
-- | Add the constructors of your data type here.
data TodoList

-- | A list without todos, none of them completed.
empty :: TodoList
empty = undefined

-- | Puts a todo at the front of the list.
add :: TodoList -> Int -> TodoList
add list todo = undefined

-- | Removes the todo at the given index and counts it as completed.
remove :: TodoList -> Int -> TodoList
remove list index = undefined

-- | The todos that are still open.
todos :: TodoList -> [Int]
todos list = undefined

-- | How many todos have been completed.
completed :: TodoList -> Int
completed list = undefined
#else
data TodoList = TodoList [Int] Int
  deriving Show

empty :: TodoList
empty = TodoList [] 0

add :: TodoList -> Int -> TodoList
add (TodoList xs n) x = TodoList (x : xs) n

remove :: TodoList -> Int -> TodoList
remove (TodoList (_ : xs) n) 0 = TodoList xs (n + 1)
remove (TodoList (x : xs) n) i = add (remove (TodoList xs n) (i - 1)) x

todos :: TodoList -> [Int]
todos (TodoList xs _) = xs

completed :: TodoList -> Int
completed (TodoList _ n) = n
#endif
