Als Teil eines ADTs für Arrays soll eine Operation
`reverse :: Array a -> Array a` spezifiziert werden, die ein Array
umdreht. Ihr Verhalten soll unter anderem durch das folgende Gesetz festgehalten sein:
#align(center)[`reverse (reverse a) == a` #h(1em) für alle Arrays `a`]
Warum ist dieses Gesetz problematisch? Wie können wir das Problem beseitigen?
