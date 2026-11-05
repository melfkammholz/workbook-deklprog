Wenn wir die Listenkonstruktoren in `foldr` einsetzen, erhalten wir die
Identitätsfunktion auf Listen, also
#align(center)[`foldr (:) [] :: [a] -> [a]`.]
Wenn wir das Gleiche mit `foldl` und angepassten `(:)` machen,
also
#align(center)[`foldl (flip (:)) [] :: [a] -> [a]`,]
dann erhalten wir nicht die Identitätsfunktion auf Listen. Warum und was
bekommen wir stattdessen heraus?
