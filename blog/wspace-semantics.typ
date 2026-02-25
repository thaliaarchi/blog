#title[A semantics for undefined behavior in Whitespace]

This is a formal semantics for the Whitespace programming language, _as
implemented_, not as specified. The #link("https://web.archive.org/web/20150618184706/http://compsoc.dur.ac.uk/whitespace/tutorial.php")[
official language tutorial] warns that it is only an informal introduction and
that the implementation itself serves as its operational semantics. As you'll
soon see, the reference interpreter has a lot of baffling undefined behavior
owing to the lazy semantics of its implementation in Haskell. Let's specify it!

But first, an introduction to the language. Whitespace is one of the most
popular esoteric programming languages, alongside Brainfuck. It's famous for its
invisible syntax, using only space, tab, and line feed; all other characters are
comments. Whitespace was created by Edwin Brady during his PhD. In a pub, he and
some friends were discussing what the most minimal syntax might be and settled
on three whitespace characters. He then hacked together an interpreter in
Haskell and #link("https://web.archive.org/web/20150612010437/http://compsoc.dur.ac.uk/whitespace/explanation.php")[
released] it on April Fools' Day 2003.

The language consists of 24 instructions, which are encoded as sequences of
whitespace characters in a prefix coding somewhat like Morse code. For example,
the _mul_ instruction is encoded as [Tab][Space][Space][LF], which I write as
_TSSL_. Integer arguments, for instructions that take them, are encoded as the
sign first, _S_ for non-negative and _T_ for negative, followed by the bits
encoded in binary, _S_ for 0 and _T_ for 1, and terminated with _L_. For
example, _push 23_ is encoded as _SS S TSTTT L_, where _SS_ is the opcode for
_push_. Label arguments are like integer arguments, but without the sign.
