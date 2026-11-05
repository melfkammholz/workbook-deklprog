date(may, 15).
date(may, 16).
date(may, 19).
date(june, 17).
date(june, 18).
date(july, 14).
date(july, 16).
date(august, 14).
date(august, 15).
date(august, 17).

#ifdef TEMPLATE
% Implement solution/2 here.
#else
months_for_day(Day, Months) :- setof(M, date(M, Day), Months).
days_for_month(Month, Days) :- setof(D, date(Month, D), Days).
ambiguous(Xs) :- Xs \= [_].

albert_statement1(Month) :-
  days_for_month(Month, Days),
  forall(
    member(Day, Days),
    (months_for_day(Day, Months), ambiguous(Months))
  ).

bernard_statement(Day) :-
  months_for_day(Day, Months),
  ambiguous(Months),
  findall(
    Month,
    (albert_statement1(Month), date(Month, Day)),
    [_]
  ).

albert_statement2(Month) :-
  findall(
    Day,
    (bernard_statement(Day), date(Month, Day)),
    [_]
  ).

solution(Month, Day) :-
  date(Month, Day),
  albert_statement1(Month),
  bernard_statement(Day),
  albert_statement2(Month).
#endif
