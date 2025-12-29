# UNIX V4 at the University of Utah

by Thalia Archibald, December 2025

<TODO: abstract>

## The discovery

This summer, a rare artifact of computing history was discovered at the
University of Utah: a magnetic tape from 1974 with the only surviving copy of
UNIX V4. Aleks Maricq, a researcher in the Flux Research Group, uncovered it in
the group's storage closet while sorting through old materials. The group, which
builds infrastructure for large computer systems, is preparing to relocate to a
new engineering building scheduled for completion next year.

Photo: Group in closet. Caption: Left to right …

When I heard the news of the discovery, I jumped out of my chair. I had spent
the summer programming with UNIX V5 on a PiDP-11 and knew that no complete copy
of V4 was known to exist. Back then, tapes and disks were expensive and not much
thought was put into keeping copies of the old. V5 is the earliest complete
UNIX distribution and can be easily run on emulated systems like the PiDP-11, a
recreation of the console panel of a PDP-11 computer, powered by the SIMH
emulator in a modern Raspberry Pi.

Photo: Tape with my PiDP. <TODO: Link to full size photos>
Caption: The UNIX V4 tape, my PiDP-11 with some switches set, and a <TODO>
terminal.

This was the first version of the influential operating system to be released
outside of Bell Laboratories and was sent to <TODO: about 30> universities. UNIX
V4 was the culmination of the effort to rewrite the kernel in C, a new
high-level programming language designed alongside UNIX. Previous attempts had
failed, but once structures were introduced into the language, it became
expressive enough to manage the complex state of the kernel and the <TODO:
summer of 1973> was dedicated to this transition.

I wrote a small blurb about V4 and shared a link <TUHS> to School of Computing's
grad school Slack in the #random channel, fully expecting little engagement, as
few people match my interest in retrocomputing. To my surprise, Rob Ricci
responded that it was found here, just down the hall! So I brought my whole lab
with me to the Flux lab to see the tape.

Photo: Me holding the tape.

## Provenance of the tape

At this point, we had little information on the tape. It was probably after the
first public presentation of UNIX was at the Symposium on Operating System
Principles in October 1973 and definitely before V5 was released in June 1974.
It was found within the papers of Jay Lepreau and the handwriting on the label
matches his,[^mastodon_handwriting] so Flux staff assumed he received it, but he
arrived at at the University in <TODO: 1980>, so it would have been someone
else.

[^mastodon_handwriting]: https://discuss.systems/@ricci/115505025036183624

Photo: Handwritten label.

My first lead came while searching for early sources on UNIX.[^mastodon_licensee]
[^mastodon_transcriptions] In ["Unix at 25"](https://web.archive.org/web/19961220135639/http://www.byte.com/art/9410/sec8/art3.htm)
by Peter Salus for BYTE, he mentions UNIX News, the first users' newsletter. It
announced news, showcased modifications sites made to their installations,
coordinated meetups, listed the first licensees and mailing list subscribers,
and distributed patches. The first regular issue was mailed on 30 July 1975 to
37 people, including Martin Newell of the University of Utah! It lists all the
subscribers and it shows that the U was the 19th licensee of UNIX!

[^mastodon_licensee]: https://discuss.systems/@ricci/115509057505895666
[^mastodon_transcriptions]: https://discuss.systems/@ricci/115526434111161343

<!-- ![UNIX News July 30 1975 page 1](unix_news_july-30-1975_page1.png) -->

![19, MR. MARTIN E. NEWELL, COMPUTER SCIENCE DEPT., UNIV. OF UTAH, SALT LAKE CITY, UTAH 84112](unix_news_july-30-1975_newell.png)

This list was derived from a [list of licensees](https://www.tuhs.org/pipermail/tuhs/2023-July/028601.html)
maintained by Ken Thompson dated 27 June 1975, which was created using a form
letter template editor with a key-value database (which appears to be a fork of
the venerable `ed` editor).

A machine-readable list of licensees was also maintained by Ken Thompson,
modified a month before this, which I am [analyzing](https://github.com/thaliaarchi/unix-form-read).

The tape was acquired at the dawn of computer graphics and considered for use in
pioneering work. Just a year later the Utah Teapot was modeled. But, UNIX was
not mature enough yet, so the tape was not used for any work and forgotten.
Perhaps this neglect allowed it to survive to today. My theory is that it was
placed in a tape rack, untouched and never overwritten. Then, after magnetic
tapes were obsolete Jay Lepreau probably saw the "UNIX V4 DIST" while cleaning
and, being the operating systems researcher that he was, saved it, writing his
own label.

https://archive.org/search?query=subject%3A%22UNIX+license%22&sort=date

![Definitions Appendix, including the contents of the UNIX distribution](distribution_contents_1974.png)

Events:

- Paul Abegglen letter to Ritchie, 21 November 1973
- UNIX V4 license agreement affective, estimated December 1973
- UNIX V4 delivery letter, 31 May 1974

## The dawn of computer graphics

Martin Newell is a pioneer in computer graphics famous for the Utah Teapot, the
most widely used model for testing graphics engines.

Photo: Teapot renderings (use low res from CHM).
Caption: It first appeared in Martin's thesis, but then spread from the
"Textures" paper. <ref: Blinn email>

The story goes that he was having tea with his wife, trying to think of a good
object to model, when she suggested that their tea set would be perfect. It has
several interesting properties: it is round, but not spherical, and it casts a
shadow on itself <TODO>. So he measured it by hand and plowed it on paper, then
typed the coordinates into a computer, and thus the Utah Teapot was born—a
process we take for granted now with 3D modeling software.

![Martin Newell's drawing of the Utah Teapot](newell_teapot_drawing.jpg)

At this time, the computer graphics group at the U was rapidly growing. From
1973 to 1975, Martin was responsible for setting up a [new graphics facility](https://archive.org/details/shaded_picture_system_proposal_1973-08-09)
in collaboration with Evans & Sutherland. E&S was a local graphics
company started by Dave Evans and Ivan Sutherland, the founders of the
University's computer science department, and had close ties to the school. They
were working on <TODO>. This facility was based on a PDP-11/45 computer that was
connected to <E&S devices>. It is most likely that UNIX V4 was acquired for this
machine. However, it seems to have barely been used.

Photo of diagram from proposal
https://archive.org/details/shaded_picture_system_proposal_1973-08-09/page/n10/mode/1up

Events:

- Martin Newell:
  - Martin Newell setting up new facility with PDP-11/45, 1973
  - PDP-11/45 in "Man Machine Communication in Three Dimensions", March 1974
  - Utah Teapot modeled, circa 1975
  - Teapot in "Texture and Reflection in Computer Generated Images", July 1976
- E&S:
  - E&S PS-2 UNIX driver, manual dated October 1978
- Others:
  - Randy Frank and Spencer Thomas at Boulder USENIX,
    28 January – 2 February 1980
  - SLC POSIX meeting, 23–27 April 1991

## Recovering the data

## Analysis of UNIX V4

https://www.tuhs.org/Archive/Applications/Dennis_Tapes/Gao_Analysis/v4_dist/setup.pdf

<TODO: My analysis of the boot sector>
