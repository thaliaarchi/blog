---
layout: post
title: "Curly braces: An evolution of UNIX and C"
date: 2026-05-19
---

# Curly braces: An evolution of UNIX and C

19 May 2026

How were `{` `}` curly braces typed with a Teletype Model 33 on UNIX? These
characters are especially important for C, but absent on this terminal. I was
just asked a similar question [^question] and in response, this is a tour of the
coevolution of UNIX and C, from this perspective, featuring "hello, world"
through the ages.

This work is entirely my own (no AI) and the code samples are my construction.
Sources for all inferences are cited.

## ASCII 1963

The Teletype Model 33 famously couldn't write lowercase letters. This
teleprinter was designed around the first edition of the ASCII standard, ASA
X3.4-1963, which hadn't yet decided lowercase was worth adding. Some in the
committee thought more control characters would be a better use of the limited
encoding space. The standard soon evolved into its modern form, but the Model 33
was the first commercial use of ASCII and wildly popular, so its issues stuck.

In addition to missing lowercase, ASCII 1963 and the Model 33 lacked `{` `}`
curly braces, `|` vertical bar, `` ` `` backtick, and `~` tilde, and they had
`↑` up arrow instead of `^` caret and `←` left arrow instead of `_` underscore.

## Trigraphs and digraphs

Curly braces are a prominent part of C syntax, used for blocks. For example:

```c
int main(int argc, char *argv[]) {
    printf("hello, world!\n");
}
```

To support character sets without these characters, C89 invented trigraphs, so
`{` could be written as `??<` and `}` as `??>`:

```c
int main(int argc, char *argv[]) ??<
    printf("hello, world!\n");
??>
```

The trigraph `??/` for `\` backslash can be used at the end of a line to produce
a line continuation, which was lexical undefined behavior when within a
universal character name. I encountered this case while writing a static
analysis, but it was later fixed in C++26 [^lexub].

Then, C95 introduced nicer-looking digraphs, so `{` can be written as `<%` and
`}` as `%>`:

```c
int main(int argc, char *argv[]) <%
    printf("hello, world!\n");
%>
```

But, trigraphs were only introduced after the Teletype Model 33 was obsolete.
How did they write C code in the early '70s?

## Terminal drivers

Starting in UNIX V4 in November 1973, the teletype driver would translate
between `\(` and `{` and between `\)` and `}`:

```c
main(argc, argv)
char *argv[];
\(
        printf("hello, world!\n");
\)
```

This support was added sometime between the nsys kernel [^nsyscanon] in August
1973 and the V4 manual in November 1973 [^v4dc]. The Utah_v4 kernel (June 1974)
[^v4canon] and Dennis_v5 kernel (November 1974) [^v5canon] have support, but
nsys, a pre-release version of V4 before pipes were added back in, does not. The
V2 and V3 kernels, which were written in assembly, did not survive, but the nsys
kernel matches the V3 manual [^v3dc] and the V1 kernel [^v1canon].

UNIX exposes devices through a common byte stream interface and this character
translation is transparent to user space programs. Programs use the bytes for
ASCII `{` `}` and the kernel translates them to `\(` `\)` on `write` to a
Teletype Model 33, or in reverse on `read`.

This escaping evolved out of the need to delete characters sent by a terminal,
since teleprinters can't erase text that's already been printed on paper. The
scheme they used, inherited from Multics, was to process input by lines and
interpret `#` "erase" as deleting the previous character and `@` "kill" as
clearing the current line. Either character can be escaped with backslash to get
the literal character.

For example, this Utah_v4 session writes that program with a Teletype Model 33
and uses @ and # to fix a few mistakes:

```
% ed hello.c
?
a
main(argc, argv)
char *argv[];
\(
        printf("hallo, welt@    printf("hello #, world!\n");
\)
.
w
63
q
% cc hello.c
% a.out
hello, world!
```

If you signed in with another terminal, you would see:

```
% cat hello.c
main(argc, argv)
char *argv[];
{
        printf("hello, world!\n");
}
```

What about before UNIX V4? From its start in June 1972 [^cstart], C used only
braces. You just needed to use a terminal that could produce braces.

## Early C structs

Interestingly, when structs were first added to C in December 1972
[^prestructparen], they used parentheses instead of braces! For a time around
nsys in August 1973, you could even write structs with either parentheses or
braces. It was fully switched to only the modern syntax at the latest by June
1974 [^v4paren]. This definition in nsys uses both styles [^nsysparen]:

```c
struct user {
        int     u_rsav[2];              /* must be first */
        /* ... */
        struct  (
                int     u_ino;
                char    u_name[DIRSIZ];
        ) u_dent;
        /* ... */
} u;    /* u = 140000 */
```

But that's just one language feature; blocks still required braces.

## B

Before C was B, an interpreted language made by Ken Thompson for UNIX. B had no
types—every value was a machine word—, perfect for the PDP-7 that UNIX started
on, with 18-bit words.

A descendant of this early B remained in use for the Honeywell 6070, far after
UNIX B was replaced with C. This machine has 36-bit words, so four characters
fit into a word. The 1973 B language tutorial for the H6070 [^bintro] had the
first-ever "hello, world" program, also using curly braces:

<!--well, ```b-->
```c
main( ) {
 extrn a, b, c;
 putchar(a); putchar(b); putchar(c); putchar('!*n');
}

a 'hell';
b 'o, w';
c 'orld';
```

## B to NB

But this everything-is-a-word strategy fails on the PDP-11, which UNIX very
quickly transitioned to. This machine has 16-bit words and 8-bit addressing.
Since addresses could then be misaligned, B on the PDP-11 needed a hack where
globals that weren't word-aligned by the linker would be patched at runtime
[^bsquoze].

So, around May 1972 [^cstart], Dennis Ritchie added `char` and `[]` pointer
types to the language, calling it "new B". Note the use of only `[]`, instead of
the later `*`:

<!--well, ```nb-->
```c
main(argc, argv)
char argv[][]; {
        printf("hello, world!\n");
}
```

## NB to C

He then turned it into a compiler that produces machine code instead of the
inefficient threaded code of B, and renamed it to C. The syntax remained the
same:

```c
main(argc, argv)
char argv[][];
{
        printf("hello, world!\n");
}
```

However, the first C compiler in June 1972 had dropped the `$(` `$)` escapes for
braces from B and support never returned [^cbrace].

But it still retained much of the semantics of B. Functions, arrays, and even
labels were indirected via a writable pointer [^chist], leading to quirks like
reassignable labels [^clvalue] [^cgdlvalue]:

```c
        goto init;
init:
        ouptr = oubuf;
        init = init1;
init1:
```

This indirection was removed when structs were added, which created a
distinction between pointers and arrays. Pointers are reassignable and arrays
are not. As such, `*` was introduced, at the latest by August 1973 [^nsysptr]:

```c
main(argc, argv)
char *argv[];
{
        printf("hello, world!\n");
}
```

With a compiler and structs, C was fast and expressive enough to rewrite the
kernel in C, culminating in the release of UNIX V4.

## PDP-11 B

Backing up from C to B, we can finally use a Teletype Model 33 again! B on the
PDP-11 supported braces, in addition to the following escapes [^bref]:

- `*0`: NUL
- `*e`: End of file
- `*(`: `{`
- `*)`: `}`
- `*t`: Tab
- `**`: `*`
- `*'`: `'`
- `*"`: `"`
- `*n`: Line feed

UNIX was ported to the PDP-11 in February 1971 [^v0date]. Some time between then
and the B reference manual in January 1972 [^bref], the use of `{` `}` curly
braces was invented, setting it apart from its predecessors. At the time of the
draft mid-1971 manual [^bv0], they were clearly using the Teletype Model 37, a
newer teleprinter that supported braces [^termsv0]. If PDP-11 B did not support
`{` `}` from the start, it gained them very shortly thereafter.

The runtime library resembles later C:

<!--well, ```b-->
```c
main() $(
        printf("hello, world!*n");
$)
```

Unfortunately, no B source code survived from this era. However, the compiled
PDP-11 B runtime from June 1972 survived [^blib] and has been disassembled, and
a compiler that produces this output has been reconstructed [^bsquoze].

## PDP-7 B

And before the PDP-11, PDP-7 B also supported `$(` and `$)` instead of, or in
addition to, braces. But it used two-char printing for the 18-bit word size:

<!--well, ```b-->
```c
main() $(
   write('he'); write('ll'); write('o,');
   write(' w'); write('or'); write('ld'); write(041012);
  $)
```

Only two B programs from the PDP-7 era of UNIX have survived, both showing this
syntax [^bprograms]:

<!--well, ```b-->
```c
main $(
   auto ch;
   extrn read, write;

   goto loop;
   while (ch != 04)
      $( if (ch > 0100 & ch < 0133)
            ch = ch + 040;
      if (ch==015) goto loop;
      if (ch==014) goto loop;
      if (ch==011)
       $( ch = 040040;
          write(040040);
          write(040040);
          $)
      write(ch);
   loop:
      ch = read()&0177;
      $)
  $)
```

This syntax is directly borrowed from its predecessor, BCPL.

## BCPL to B

B was Ken Thompson's version of BCPL, simplified to its core, as he so often
did. The name too was a contraction of either BCPL or Bon, an unrelated language
he created during his Multics days [^chist].

An example in the style of the 1967 BCPL manual, reflecting the state of the
language at the time B forked from it [^bcpl67]:

<!--well, ```bcpl-->
```c
let Start() be
       $( Writech(MONITOR,'h'); Writech(MONITOR,'e'); Writech(MONITOR,'l')
          Writech(MONITOR,'l'); Writech(MONITOR,'o'); Writech(MONITOR,',')
          Writech(MONITOR,' '); Writech(MONITOR,'w'); Writech(MONITOR,'o')
          Writech(MONITOR,'r'); Writech(MONITOR,'l'); Writech(MONITOR,'d')
          Writech(MONITOR,'!'); Writech(MONITOR,'*n')  $)
```

Although this manual uses mixed letter case and rich symbols, the canonical
style was uppercase [^bcpldmr]. The 1967 manual does not specify an entrypoint,
so I adapted `Start` from `START` in the 1979 BCPL book [^bcpl79].

BCPL only gained `{` and `}` for blocks later, in imitation of C [^bcpldmr].

## Teletype Model 37

Even before UNIX V4 extended the terminal driver to replace `\(` and `\)` for
the Teletype Model 33, UNIX programmers had stopped writing B code with `$(` and
`$)`. They had moved on from the Model 33 to the Teletype Model 37, its
successor.

The Model 37 was 50% faster and supported the full, modern ASCII character set.
They were no longer limited to the ASCII 1963 subset.

It was the most advanced electromechanical teleprinter ever made, i.e., it
operates purely mechanically without digital logic, but was soon obsolesced by
video terminals.

It had many escape sequences: black and red colors, half-forward and
half-reverse line feeds (useful for sub- and superscripts), reverse line feed,
horizontal and vertical tab setting, and half- and full-duplex [^37notes]
[^37type]. Last year, Brian Kernighan recounted a humorous use of one of these
features in the UNIX group: Robert Morris Sr. sent an email to Joe Ossanna which
contained a hundred reverse line feeds, making it suck the long fan-fold paper
out the back of the Model 37 and drop it on the floor [^37vcf].

## Terminals on UNIX

UNIX gained Teletype Model 37 support early on and it quickly became preferred.

PDP-7 UNIX supported only the Model 33 [^termspdp7]. But, already before the
UNIX V1 manual was finalized, a draft mid-1971 manual implies that many UNIX
users were already using the Teletype Model 37 [^termsv0]. The V1 kernel
supported the Model 37 [^termsv1]. `login` from V2 at the latest to V5 would
cycle through speeds and login messages for different terminals, supporting the
TermiNet 300 and Teletype Model 37 [^termsv245]. It grew in V6, once `getty` was
rewritten in C, to support many more terminals and further in V7, but still
supported the Model 37 [^termsv67].

No version of the assembly kernel uses braces in its source code, even V1, once
development used the Model 37.

## Modern implications

The character set limitations of the Teletype Model 33 have had lasting
influence on modern computing.

UNIX uses lowercase almost exclusively. This is still Ken's writing style
[^kenlower].

PDP-7 UNIX sources don't contain a single underscore (it would have been `←` on
the Model 33). Later versions use it sparingly. The core of libc still uses
flatcase naming style.

Identifiers in C were very short to fit within the 7 or 8-byte limit. Many such
functions are still in libc. Though, that's due to the assembler—a topic worthy
of another post, once I finish my assembler.

Design decisions from 1963 still affect us today, 63 years later!

---

*I collect teletypes and am seeking a Teletype Model 37 [^mytty37]. If you have
any leads on one, please get in touch! And, I hope to eventually acquire a
PDP-11 too.*

## Appendix: hello, world

All the "hello, world" snippets, together:

```c
// BCPL, circa 1967
let Start() be
       $( Writech(MONITOR,'h'); Writech(MONITOR,'e'); Writech(MONITOR,'l')
          Writech(MONITOR,'l'); Writech(MONITOR,'o'); Writech(MONITOR,',')
          Writech(MONITOR,' '); Writech(MONITOR,'w'); Writech(MONITOR,'o')
          Writech(MONITOR,'r'); Writech(MONITOR,'l'); Writech(MONITOR,'d')
          Writech(MONITOR,'!'); Writech(MONITOR,'*n')  $)

/* PDP-7 B, 1969 */
main() $(
   write('he'); write('ll'); write('o,');
   write(' w'); write('or'); write('ld'); write(041012);
  $)

/* PDP-11 B, 1971 */
main() $(
        printf("hello, world!*n");
$)

/* NB, May 1972 */
main(argc, argv)
char argv[][]; {
        printf("hello, world!\n");
}

/* Early C, June 1972 */
main(argc, argv)
char argv[][];
{
        printf("hello, world!\n");
}

/* C, August 1973 at the latest */
main(argc, argv)
char *argv[];
{
        printf("hello, world!\n");
}

/* C and UNIX V4, November 1973 */
main(argc, argv)
char *argv[];
\(
        printf("hello, world!\n");
\)

/* C89, 1989 */
int main(int argc, char *argv[]) ??<
    printf("hello, world!\n");
??>

/* C95, 1995 */
int main(int argc, char *argv[]) <%
    printf("hello, world!\n");
%>

// C99, 2000
int main(int argc, char *argv[]) <%
    printf("hello, world!\n");
%>
```

## References

[^question]: ["What Teletype are you using? The ASR33 lacks curly brackets which
    makes me skeptical it was used in C development. Yes, there are trigraphs (
    https://en.wikipedia.org/wiki/Digraphs_and_trigraphs_(programming) ) but
    FWIU these came some time later."](https://mastodon.radio/@vk2bea/116601334222030852)
    by Michael Katzmann, 19 May 2026


[^v3dc]: UNIX Programmer's Manual Third Edition, [dc(4)](http://squoze.net/UNIX/v3man/man4/dc)
    "dc -- DC-11 communications interfaces", February 1973

[^v4dc]: UNIX Programmer's Manual Fourth Edition, [dc(4)](http://squoze.net/UNIX/v4man/man4/dc)
    "dc -- DC-11 communications interfaces", November 1973

[^v1canon]: UNIX V1 <code><a href="https://www.tuhs.org/cgi-bin/utree.pl?file=V1/u7.s">u7.s</a>:canon</code>,
    snapshotted 14 September 1972

[^nsyscanon]: nsys <code><a href="https://www.tuhs.org/cgi-bin/utree.pl?file=Nsys/dmr/tty.c">/usr/sys/dmr/tty.c</a>:canon</code>,
    modified and snapshotted 31 August 1973

[^v4canon]: Utah_v4 <code><a href="https://www.tuhs.org/cgi-bin/utree.pl?file=V4/usr/sys/dmr/tty.c">/usr/sys/dmr/tty.c</a>:canon</code>
    and `mptab`, modified 10 June 1974,
    and <code><a href="https://www.tuhs.org/cgi-bin/utree.pl?file=V4/usr/sys/dmr/lp.c">/usr/sys/dmr/lp.c</a>:lpcanon</code>,
    modified 10 June 1974, snapshotted 12 June 1974

[^v5canon]: Dennis_v5 <code><a href="https://www.tuhs.org/cgi-bin/utree.pl?file=V5/usr/sys/dmr/tty.c">/usr/sys/dmr/tty.c</a>:canon</code>
    and `mptab`, modified 26 November 1974,
    and <code><a href="https://www.tuhs.org/cgi-bin/utree.pl?file=V5/usr/sys/dmr/lp.c">/usr/sys/dmr/lp.c</a>:lpcanon</code>,
    modified 26 November 1974, snapshotted 21 March 1975


[^bcpl67]: ["The BCPL Reference Manual"](https://softwarepreservation.computerhistory.org/BCPL/project_mac/Richards-BCPL-ReferenceManual.pdf)
    by Martin Richards, 21 July 1967, and a [forward by Dennis Ritchie](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/bcpl.html)

[^bcpl79]: [*BCPL - the language and its compiler*](https://archive.org/details/richards1979bcpl)
    by Martin Richards and Colin Whitby-Stevens, 1979

[^bcpldmr]: ["Martin Richards's BCPL Reference Manual, 1967"](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/bcpl.html),
    foreword by Dennis Ritchie


[^bv0]: ["DRAFT: The UNIX Time-Sharing System](https://www.tuhs.org/Archive/Distributions/Research/McIlroy_v0/UnixEditionZero-Threshold_OCR.pdf)
    by Dennis Ritchie, circa mid-1971, and [transcribed](https://github.com/thaliaarchi/unix-history/blob/main/manuals/v0.txt),
    documents the `b` command

[^v0date]: ["Hidden Early History of Unix"](https://papers.freebsd.org/2020/fosdem/losh-hidden_early_history_of_unix/)
    by Warner Losh, FOSDEM '20, February 2020

[^bref]: ["Users' Reference to B"](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html)
    by Ken Thompson, 7 January 1972

[^bintro]: "A Tutorial Introduction to the Language B" by Brian Kernighan,
    [Bell Laboratories Computing Science Technical Report #8: The Programming Language B](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/bintro.html),
    January 1973

[^blib]: [Dennis_Tapes] s2 `/usr/lib/bilib.a`, modified 8 June 1972, and
    `/usr/lib/libb.a`, modified 19 June 1972

[^bsquoze]: ["The B Programming Language"](http://squoze.net/B/)
    by Angelo Papenhoff, first published 2019

[^bprograms]: PDP-7 UNIX [`ind.b`](https://github.com/DoctorWkt/pdp7-unix/blob/master/src/cmd/ind.b)
    and [`lcase.b`](https://github.com/DoctorWkt/pdp7-unix/blob/master/src/cmd/lcase.b),
    pages 2 and 4 of Norman Wilson's [08-rest.pdf](https://www.tuhs.org/Archive/Distributions/Research/McIlroy_v0/08-rest.pdf),
    undated


[^chist]: ["The Development of the C Language"](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/chist.html)
    by Dennis Ritchie, 1993

[^cstart]: The earliest surviving file of any C compiler is [Dennis_Tapes]
    <code><a href="https://www.nokia.com/bell-labs/about/dennis-m-ritchie/primevalC.html">last1120c</a>/<a href="https://www.tuhs.org/cgi-bin/utree.pl?file=V2/c/sptab.s">sptab.s</a></code>,
    modified 4 June 1972 (some ar archive members may be modified sooner, but
    their epoch looks wrong). The earliest surviving .c file is [Dennis_Tapes]
    `dmr/cgd/cvft.c`, modified 11 June 1972. The only surviving NB .b file is
    [Dennis_Tapes] `dmr/fc.b`, modified 4 May 1972 (all other .b files are
    untyped). Thus, NB evolved into C during May and early June 1972.

[^clvalue]: ["A cursed feature of C in 1972"](https://discuss.systems/@thalia/116547910760959567)
    by Thalia Archibald, 9 May 2026

[^cgdlvalue]: [Dennis_Tapes] `dmr/cgd/cvft.c:putchar` and `getcha`,
    modified 11 June 1972

[^nsysptr]: The earliest surviving C file to use `*` for pointers is
    nsys [`/usr/sys/ken/iget.c`](https://www.tuhs.org/cgi-bin/utree.pl?file=Nsys/ken/iget.c),
    modified 30 August 1973

[^cbrace]: `$` and `\` are unknown characters in the earliest C compiler lexer in
    [Dennis_Tapes] <code><a href="https://www.nokia.com/bell-labs/about/dennis-m-ritchie/primevalC.html">last1120c</a>/<a href="https://www.tuhs.org/cgi-bin/utree.pl?file=V2/c/nc0/c02.c">nc0/c02.c</a>:statement</code>,
    <code><a href="https://www.nokia.com/bell-labs/about/dennis-m-ritchie/primevalC.html">last1120c</a>/<a href="https://www.tuhs.org/cgi-bin/utree.pl?file=V2/c/nc0/c00.c">nc0/c00.c</a>:symbol</code>,
    and <code><a href="https://www.nokia.com/bell-labs/about/dennis-m-ritchie/primevalC.html">last1120c</a>/<a href="https://www.tuhs.org/cgi-bin/utree.pl?file=V2/c/nc0/c0t.s">nc0/c0t.s</a>:ctab</code>,
    modified July 1972


[^prestructparen]: The C parser in [Dennis_Tapes]
    <code><a href="https://www.nokia.com/bell-labs/about/dennis-m-ritchie/primevalC.html">prestruct-c</a>/<a href="https://www.nokia.com/bell-labs/about/dennis-m-ritchie/prestruct-c/c00.c">c00.c</a>:tdeclare</code>,
    modified 6 December 1972, snapshotted 8 December 1972, only accepts the
    parenthesis form.

[^nsysparen]: nsys <code><a href="https://www.tuhs.org/cgi-bin/utree.pl?file=Nsys/user.h">/usr/sys/user.h</a>:struct user</code>,
    modified and snapshotted 30 August 1973, uses both parenthesis- and
    brace-style structs in the same file.

[^v4paren]: Utah_v4 <code><a href="https://www.tuhs.org/cgi-bin/utree.pl?file=V4/usr/c/c02.c">/usr/c/c02.c</a>:strdec</code>,
    modified 10 June 1974, snapshotted 12 June 1974


[^lexub]: P2621R3: ["UB? In My Lexer?"](https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2023/p2621r3.pdf)
    by Corentin Jabot, 6 April 2023


[^37notes]: ["Teletype Model 37 functional specification"](https://github.com/thaliaarchi/tty37-docs/blob/main/tty37.md#escape-sequences)
    by Thalia Archibald, 2025

[^37type]: ["37 Typing Unit (37P003 and up): Description and Principles of Operation"](https://www.navy-radio.com/manuals/tty/m37/574-320-101-iss2-7302.pdf),
    Teletype Corporation, Bell System Practices, Section 574-320-101, Issue 2,
    February 1973, section 4.23

[^37vcf]: VCF East: ["UNIX: A History and a Memoir"](https://www.youtube.com/watch?v=WEb_YL1K1Qg&t=2940s)
    by Brian Kernighan, 15 August 2025, 49:00 and [transcribed](https://github.com/thaliaarchi/tty37-docs/blob/main/unix.md#teletype-model-33-and-37-use-in-unix)


[^termspdp7]: PDP-7 UNIX `init` supported only a generic tty in [`init.s:init1`](https://github.com/DoctorWkt/pdp7-unix/blob/master/src/cmd/init.s#L19),
    almost certainly the Teletype Model 33, and the machine's keyboard and display
    in [`init.s:init1`](https://github.com/DoctorWkt/pdp7-unix/blob/master/src/cmd/init.s#L29).

[^termsv0]: ["DRAFT: The UNIX Time-Sharing System](https://www.tuhs.org/Archive/Distributions/Research/McIlroy_v0/UnixEditionZero-Threshold_OCR.pdf)
    by Dennis Ritchie, circa mid-1971, and [transcribed](https://github.com/thaliaarchi/unix-history/blob/main/manuals/v0.txt),
    writes "Currently this signal is generated by typing the ASCII "FS" character
    (control `\` on model 37 Teletypes)", implying common use of the Teletype
    Model 37, though other terminals are also mentioned. The document itself
    uses half line feeds and `` ` ``, `^`, and `_` characters, features of the
    Model 37.

[^termsv1]: UNIX V1 <code><a href="https://www.tuhs.org/cgi-bin/utree.pl?file=V1/u7.s">u9.s</a>:trcv</code>,
    snapshotted 14 September 1972, switched between Teletype Model 37/non-37
    parity filtering.

[^termsv245]: `getty` from V2 to V5 cycles through speeds and login messages,
    starting with TermiNet 300, then Teletype Model 37. Other terminals were
    supported by drivers.
    [Dennis_Tapes] s1 [`getty.s`](https://github.com/DoctorWkt/unix-jun72/blob/master/src/cmd/getty.s#L147),
    modified circa June 1972.
    Utah_v4 [`/usr/source/s1/getty.s`](https://www.tuhs.org/cgi-bin/utree.pl?file=V4/usr/source/s1/getty.s),
    modified 10 June 1974, snapshotted 12 June 1974.
    Dennis_v5 [`/usr/source/s1/getty.s`](https://www.tuhs.org/cgi-bin/utree.pl?file=V5/usr/source/s1/getty.s),
    modified 27 November 1974, snapshotted 21 March 1975.

[^termsv67]: Dennis_v6 [`/usr/source/s1/getty.c`](https://www.tuhs.org/cgi-bin/utree.pl?file=V6/usr/source/s1/getty.c),
    modified 13 May 1975, snapshotted 18 July 1975.
    Spencer_v7 [`/usr/src/cmd/getty.c`](https://www.tuhs.org/cgi-bin/utree.pl?file=V7/usr/src/cmd/getty.c),
    modified 5 May 1979, snapshotted 8 June 1979.


[^kenlower]: ["[TUHS] Unix gre, forgotten successor to grep (was: forth on early unix)"](https://www.tuhs.org/pipermail/tuhs/2025-September/032567.html)
    by Ken Thompson, 23 September 2025, and
    ["[TUHS] A PDP-10 used for UNIX just after the PDP-7?"](https://www.tuhs.org/pipermail/tuhs/2026-January/033094.html)
    by Ken Thompson, 16 January 2026


[^mytty37]: ["Teletype Model 37 documentation"](https://github.com/thaliaarchi/tty37-docs)
    by Thalia Archibald, 2025


[Dennis_Tapes]: https://www.tuhs.org/Archive/Applications/Dennis_Tapes/
