Das Sequenzieren von Berechnungen haben wir bereits in einfacherer Form als Funktionskomposition kennengelernt. Im Kontext von Monaden stellen wir fest, dass sich Funktionen `f :: a -> m b` und `g :: b -> m c` nicht mit `(.)` komponieren lassen.

Finde ein Beispiel, das dieses Szenario illustriert, und definiere eine passende Kompositionsfunktion `(>=>) :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c`.
