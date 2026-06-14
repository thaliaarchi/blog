# UNIX V4: History and recovery

Thalia Archibald \
VCF PNW, 2 May 2026

So I'm here to talk about UNIX version 4 and our recovery of it.

[CHEERING]

Let's go. So you all know about UNIX. That's great.

Okay, so I'm a PhD student at the University of Utah, studying computer science
and verifying compilers.

I work in the Merrill Engineering Building,

and it's here that we found a UNIX tape. So this tape is from 1974. It was found
by Aleks Maricq while cleaning up in preparation for our move to the new
building.

And understandably, we're all very excited about this.

And so it was found among the items of Jay Lepreau. He's an OS researcher. He
passed away in 2008. But he had been at the U since 1980 and was involved in
some early UNIX work.

So as an example, his first project was on building a virtualized version of
UNIX for TOPS-20 on the PDP-10. And so as you probably know, the PDP-10 has a
word size that's not divisible by 8. So this made things difficult for C. But he
managed, and he ported the early portable C compiler PCC to the PDP-10. "Both
TOPS-20 and UNIX are 'nice'."

And we have a few vestiges of the minicomputer era: In our server room, we have
a PDP-11 rack.

So UNIX, as you all know, is an operating system created in the '70s by a team
at Bell Labs, led by Ken Thompson and Dennis Ritchie. Here's the two of them
working on a Teletype Model 33 with a PDP-11.

And we have this family tree of UNIX. UNIX has quite a broad family. The main
lineage is V1 through V7, later V8 through V10, but most people didn't really
use that. And until recently, we did not have V4. There are other scattered
releases. And we're working on getting more.

So when we announced this, we quickly learned that ours was unique. And so I was
pulled in the moment they announced. I had been involved with UNIX
retrocomputing, and so I knew we didn't have V4. And very exciting.

So we took it to the Computer History Museum, to their research archives.

And there they have a software preservation lab.

And in this lab, they have all sorts of drives and various gizmos to recover
from all sorts of vintage media.

And so Al Kossow led the effort. Al, he prepared for reading our tape by running
through his process with a tape of a similar vintage. So this here is an oven to
bake it. Fortunately, we didn't need to bake our tape. This is needed to make
sure that the binders don't come off as you're reading it. But ours was in
pristine condition.

So he loaded it into this other tape drive, the purpose just being that he
cleans it with alcohol [cyclomethicone] as it runs through, so that when we do
the actual read—

in this tape drive, it goes smoothly.

So this tape drive is modified. What he's done is hooked into the drive before
it interprets it as digital data. So it's directly capturing the analog waveform
with this Saleae Logic Analyzer.

And that is fed into his Linux box. There he's running Saleae Logic Pro and
capturing the waveform. And it's sampling it 10 times more than what's
necessary. So we're really getting the best fidelity that we need.

This is a nine-track tape. So nine-track means you have one track for a bit in a
byte, and then an extra track for parity. So we have some error checking. We
also have error checking at the block level. And so we just generally can tell
if our tape is read correctly.

This process was developed by Len Shustek. He had this tape for 50-some-odd
years from his university days. He wrote a project in PL/I and has wanted to
recover it. So he built `readtape`. After paying $1,000 to have an unsuccessful
recovery from another company, he did it himself.

And so here we had to troubleshoot a bit to get the parameters right and Len
stepped in.

And we had a successful read. So here is our very initial analysis with it up in
`less`, not even a nice hex dump. And I've got V4 compared with V5, and we could
tell this is something earlier. So that was great.

Well, what was next is running it.

So I was impatient. The moment I got it, I uploaded it. And before I even got
back to the hotel,

it was already emulated. [LAUGHTER] So Angelo Papenhoff, he threw it in the SIMH
emulator and he wrote instructions up for everyone else to do it. And so when I
got back from the trip, this is me running it with my PiDP-11 that I've got up
front and my Lions' Commentary.

And then it was run on a PDP-11/45.

And so the first time running Unreal hardware in 50 years by Jacob Ritorto.

And then on a PDP-11/40 by Ian Ashlin [Ashlin Inwood]. Then I went to ICM and
Stephen indulged me. We tried booting on Miss Piggy, a PDP-11/70.

But we had issues. So more repairs were needed. And people who actually know
what they're doing with an 11/70 came in and fixed it in the coming weeks.

As an aside, ICM also has an interesting DEC GT-40. It's a PDP-11 plus a VT-11.
And this is interesting to me because it came from the University of Utah.

So at this point, we knew nothing about where it came from. So I went to
archives. I found a bunch of sources in our Special Collections and scanned a
lot,

producing a fun little dossier.

My best source was UNIX News. This was the first issue sent to only 37 people.
And this was shortly after the initial public release of UNIX, only about a year
and a half later. This was the user group.

The full mailing list was published. And people exchanged software with each
other. And they sent in their fixes. It was very collaborative.

And well, number 19 stands out. That's the University of Utah. And if you call
that phone number, it still works. It goes to our School of Computing front
office. Well, if you do anything with computer graphics, you might recognize the
name Martin Newell. And I'll get to him.

So I did all this digging. And then Aleks, who found the tape, found this letter
from Ken, apologizing that they were delayed shipping the system because they
needed to print more docs. So now this is quite an interesting tidbit because
the tape is from June 1974 and UNIX V5 was released in June 1974, but the
documentation we received was for V4. So what happened is we probably got the
very last printing of the documentation. And because in those days when you got
a distribution, you'd ask Ken, "is today a good day to cut a tape?", and if it
was, he'd copy it for you. But if not, he'd say, "oh, I've got some bugs to fix;
come back later." So it was very bleeding edge. And so ours is not really V4.
But it is V4 because UNIX was versioned by the manual, so I still call it V4.
But it's pretty much the cleanest V5 you could get. The other V5 we have is nine
months later.

So this has a weird connection. So I mentioned Martin Newell.

Well, he is known for the Utah teapot. I have mine up here in the front as well
as a 3D printed one. And he was doing computer graphics research.

And in his thesis, he needed a good test model. So he was having tea with his
wife, discussing the problems he was having. And she suggested, well, how about
you just model our teapot? And so he did, getting out some calipers, writing
down a bunch of coordinates, all a very manual process.

And the project that this was for was running a Shaded Picture System. Now, at
the core of this was a PDP-11/45. And I believe it was never connected to the
timeshared PDP-10 and the ARPANET, but this was the proposal and it may have
been. And so this is the system I believe that UNIX would have been used on,
except it was never used. So Martin requested the tape. And it was too flaky. I
got in touch with him and Jim Blinn, his student at the time. And they were
saying that the file system—they'd have to go in and fix some inodes—and it just
was not stable. And so they used DEC's DOS operating system, and then later,
RT-11 [RSX-11M]. So that's also why the tape was so pristine. It just sat on a
shelf.

But in his thesis, it has the very first renderings of the Utah teapot.

Here is the full tea set.

And here is the teapot, along with some other items, meshes for it.

The novel part of his thesis was introducing procedural modeling. So instead of
storing a bunch of meshes, as in storing a huge heap of triangles, instead you
compute it from Bézier curves. And that's much more space efficient and works
well on the computers of the time, and still today, we still use this.

Another thing modeled was Ivan Sutherland's Volkswagen car.

And so here they are measuring. [LAUGHTER]

And then his student, Jim Blinn, famous for Blinn–Phong shading, in this paper
about textures and reflection, he needed a fun model. So they picked the teapot.
And they were doing a demo one day and wanted to show how flexible their system
was. So they decided to shrink the teapot. Well, they realized they liked it a
third shorter, so then it stuck. Now everyone's teapot models are the Blinn
aspect ratio. So that's my 3D printed one over there; that's Blinn aspect ratio.
In this paper, on the left, are textured teapots. They just picked some fun
images. And then on the right, there's textures plus reflections. So there is
the environment modeled with the lighting coming through the windows. And you
can see the windows reflecting onto the teapot. And so this was all very new at
the time. This looks great for the '70s, this is crazy. And so all of this
pioneering research has been built on ever since.

The teapot has been in numerous productions because researchers from the
University of Utah pretty much jump-started graphics. So Pixar was started from
a Utah alum. And it was in Pixar.

It is one of the six platonic solids. [LAUGHTER]

And we have in our office a signed teapot from him and Jim Blinn.

*The* teapot is at the Computer History Museum. We did a fun little tour after
reading the tape.

We brought it to a UNIX V1 manual and a PDP-11/20 to its left.

This is Al Kossow's personal teapot.

And so for the future, I want to preserve more UNIX distributions. There are a
lot of gaps. And even this is incomplete; this family tree dates from a PhD
thesis in 1988.

So I'm working on open sourcing—on getting the rights—, and archiving some other
distributions. So up next for me is HPBSD and HP-UX, stored on some magneto
optical disks that we have at the U.

And yeah, thank you. [APPLAUSE]

Questions?

[Audience:] What was the name of your professor that did the connections? So you
guys can read the tape.

Connections?

[Audience:] When you guys were transcribing the UNIX 4 magnetic tape, he had
connected those wires to the—

[Audience:] the logic probe.

[Audience:] Yes.

So this was Al Kossow, the software curator at the Computer History Museum.
Quite a few slides.

[Audience:] Right, right there.

He is the guy behind Bitsavers.

[Audience:] Oh, okay.

Yeah?

[Audience:] So you mentioned that you didn't have to bake your tape. How were
you able to determine that? Was it just visual inspection, or just did you do
some kind of analysis and determine that it did not need baking?

Yeah, so it was purely visual. He's done enough of these magnetic tape
recoveries, he just knew. And from the photos we shared initially online, even
just from the low res Mastodon photos, he could tell then that we probably
wouldn't need anything complicated. And when he opened the tape and pulled it
out, it was clear that it was coming off cleanly and nothing special had been
needed.

Yeah?

[Audience:] What was the material used to clean the tape and the solution it was
soaked with?

I believe just alcohol. If you want to hear more details about the recovery, I
covered most of it, but that specific detail Al Kossow covers in the CHM's
interview that they did and released in February.

[Audience:] Thank you.

[Further questions not recorded]
