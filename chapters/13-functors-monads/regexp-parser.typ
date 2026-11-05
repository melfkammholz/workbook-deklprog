Um das Abenteuer in den regulären Sprachen abzurunden, kombinieren wir nun
unsere Erkenntnisse aus den Challenges zu den regulären Sprachen mit denen
zu Parsern.

Hier ist eine kontextfreie Grammatik für reguläre Ausdrücke, die du nutzen
kannst, um einen entsprechenden Parser zu implementieren. Implementiere den Parser als Funktion `parseRegExp :: String -> Maybe RegExp`. Mit diesem Parser könntest du anschließend die `Read`-Instanz aus ```text RegExp.hs``` ersetzen, die bisher `ReadP` nutzt.

$
"RegExp" &::= "Term" (mono("|") "Term")^* \
"Term" &::= "Factor"^* \
"Factor" &::= "Atom" (mono("*"))^* \
"Atom" &::= "Letter" | mono("(") "RegExp" mono(")") \
$

Um die leere Sprache parsen zu können, kannst du unter $"Atom"$ einen Buchstaben nutzen, der für die leere Sprache stehen soll --- allerdings
kannst du diesen dann nicht mehr als normalen Buchstaben verwenden. Hier müsstest du den entsprechenden Buchstaben dann "escapen".
