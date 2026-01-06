# TODO

## Features

- Fix CSS on mobile
- Add `meta[property="article:published_time"]` and
  `meta[property="article:modified_time"]`
- Generate Atom feed
  - https://www.rfc-editor.org/rfc/rfc4287

## Post ideas

- Early UNIX at the University of Utah and V4
- Early UNIX at the University of Alberta
- Evans & Sutherland connection to BYU's CS Animation dept and CS PhD
- V6 vs xv6
- Perl 1.0 regular expression provenance
- The historical context of Dijkstra's “Go To Statement Considered Harmful”:
  - Everyone misses that structured programming was not yet the norm. The paper
    was about the common use of exclusively goto. Talk about Ratfor bringing
    C-style control flow to Fortran. Occasional use for error handling and
    interpreters is fine!
  - In response to <https://parallelprogrammer.substack.com/p/go-to-statement-considered-occasionally>
    among others.
  - Dijstra's original submission <https://www.cs.utexas.edu/~EWD/transcriptions/EWD02xx/EWD215.html>
  - Dijstra: “I had submitted a paper under the title "A case against the goto
    statement", which, in order to speed up its publication, the editor had
    changed into a "letter to the Editor", and in the process he had given it a
    new title of his own invention! The editor was Niklaus Wirth.”
    <https://www.cs.utexas.edu/~EWD/transcriptions/EWD13xx/EWD1308.html>
  - John Lions: “The source code is for the most part quite readable and
    although a few "goto"s are used, it is generally well structured and there
    is no need to resort to flowcharts for documentation.”
    <https://dl.acm.org/doi/pdf/10.1145/775396.775402>
- A comparison of BibTeX and [Hayagriva](https://github.com/typst/hayagriva),
  Typst's own bibliography system which is strongly typed and has parent items
  - Is Hayagriva weakly typed?
  - Are they isomorphic? I suspect Hayagriva is a proper superset of BibTeX,
    because of its parent feature.
  - [BibTeX tutorial](https://ftp.rrze.uni-erlangen.de/ctan/info/bibtex/tamethebeast/ttb_en.pdf)
  - [Citation styles](https://github.com/citation-style-language)
- List of jq programs
- Whitespace lazy semantics

## Styling

- Formatted like an RFC: https://noratrieb.dev/
- Directory-style navbar (but do `dir/`): https://bhargavkulk.github.io/

## Generators

- Typst static site generator
  - [Typsite](https://github.com/Glomzzz/typsite): Static site generator for
    Typst.
  - Blog generated from Typst with Astro.
    [[generator and content](https://github.com/Myriad-Dreamin/blog)]
    [[discussion](https://forum.typst.app/t/one-command-to-build-blogs-with-typst/4388)
  - Jackson's note taking site uses Typst via the Rust library to handle
    incrementality of the HTML viewer for watching thousands of notes files.
    [[generator](https://github.com/broughjt/phelps)]
  - Hanwen's Notty is for note taking in Typst, exporting to PDF and HTML.
    [[generator](https://github.com/hanwenguo/notty)]
    [[site](https://hanwenguo.github.io/notty/)]
    [post [1](https://hanwen.io/en/posts/use_typst_for_math_in_blog/),
    [2](https://hanwen.io/en/posts/use_typst_for_more_than_math_in_blog/)]
  - Typst file watcher. https://github.com/typst-doc-cn/news/blob/main/scripts/build.mjs
- [Zine](https://zine-ssg.io/): Static site generator in Zig with extended
  Markdown and strictly validated HTML.
- Bhargav's Asciidoc Makefile-driven static site generator: https://github.com/bhargavkulk/bhargavkulk.github.io
