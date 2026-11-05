Der Nichtdeterminismus im Beweis einer Anfrage tritt genau dann auf, wenn
mehrere Regeln passen. Hier ist ein einfaches Prolog-Programm, das auf Basis einer Benutzereingabe $n in NN$ die $n$-te Fibonacci-Zahl berechnet.
```prolog
:- initialization(main, main).

main :-
  write('Enter a number (end with a period): '),
  read(N),
  fib(N, F),
  format('fib(~w) = ~w\n', [N, F]),
  halt.

fib(0, 0).
fib(1, 1).
fib(N, F) :-
  N > 1,
  N1 is N - 1,
  N2 is N - 2,
  fib(N1, F1),
  fib(N2, F2),
  F is F1 + F2.
  ```
Vergleiche dieses Programm mit dem folgenden Python-Programm bzgl. des
Programmablaufs (dabei kannst du die Syntax für das Ein- und Ausgeben von
Daten ignorieren). Wie wird der gegenseitige Ausschluss der
`fib/2`-Regeln gewährleistet?
```py
def main():
  print('Enter a number: ', end='')
  n = int(input())
  f = fib(n)
  print(f'fib({n}) = {f}')
  exit()

def fib(n):
  if n == 0:
    return 0
  if n == 1:
    return 1
  if n > 1:
    n1 = n - 1
    n2 = n - 2
    f1 = fib(n1)
    f2 = fib(n2)
    f = f1 + f2
    return f
```
Wenn vor dem Literal `N > 1` ein `writeln('fib')` eingefügt wird, wie oft wird dann für die Eingabe `3` das Wort `fib` ausgegeben und warum?
