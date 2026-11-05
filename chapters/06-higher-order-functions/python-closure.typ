In das folgende Python-Programm hat sich ein bug hineingeschlichen.
```py
text = 'Ja, ja, ich back mir \'nen Kakao!'
say_words = []

for word in text.split():
  say_words.append(lambda sep: print(word, end=sep))

for say_word in say_words[:-1]:
  say_word(' ')
say_words[-1]('\n')
```
Dieses Programm gibt sieben Mal "Kakao!" aus. Erkläre, wie dieses Verhalten zustande kommt. Wie kannst du den bug beheben? Kann der gleiche Fehler in
Haskell passieren?
