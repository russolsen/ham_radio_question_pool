# Ham Radio Question Pool

Amateur radio question pools in various formats.

In the US most anyone can
[get a license](https://www.fcc.gov/wireless/bureau-divisions/mobility-division/amateur-radio-service)
to operate an amateur radio station (i.e. HAM radio) by taking a multiple choice test.
There are no age restrictions and the test questions
are publically available.

There are actually three tests of increaing difficulty:
* Technician
* General
* Amateur Extra

Passing the technican test means that you get a technican
license which allows you to operate a station in various
specific radio bands, mostly in the VHF and UHF regions of
the radio spectrum.

Passing the general test in addition to the technician
test gives you access to more frequencies while passing
the amateur extra test gives you even more.

You do need to pass the tests in order, first technician,
then general, then amateur extra, but there's no requirement
that you keep going - you can stop at technican or general.

In any case, while the questions are publically available at
[NCVEC](https://www.ncvec.org/), they are delivered
in Word or PDF format. This project aims to make the questions
accessable in various machine readable formats, including:
* JSON
* YAML
* CSV
* Simple plain text

## Usage

The JSON version looks like this:

```json
[
  {
    "id": "T1A10",
    "correct": 3,
    "question": "Which of the following describes the Radio Amateur Civil Emergency Service (RACES)?",
    "answers": [
      "A radio service using amateur frequencies for emergency management or civil defense communications",
      "A radio service using amateur stations for emergency management or civil defense communications",
      "An emergency service using amateur operators certified by a civil defense organization as being enrolled in that organization",
      "All of these choices are correct"
    ]
  }
]
```
Note that the correct answer index is *zero* based, so that the
correct answer to question `T1A10` is the fourth one,
`All of these choices are correct`.

Given all that, the YAML version is about what you would expect:

```yaml
---
- :id: T1A10
  :correct: 3
  :question: Which of the following describes the Radio Amateur Civil Emergency Service
    (RACES)?
  :answers:
  - A radio service using amateur frequencies for emergency management or civil defense
    communications
  - A radio service using amateur stations for emergency management or civil defense
    communications
  - An emergency service using amateur operators certified by a civil defense organization
    as being enrolled in that organization
  - All of these choices are correct
```

And the CSV:

```
id,correct,question,a,b,c,d
T1A10,3,Which of the following describes the Radio Amateur Civil Emergency Service (RACES)?,A radio service using amateur frequencies for emergency management or civil defense communications,A radio service using amateur stations for emergency management or civil defense communications,An emergency service using amateur operators certified by a civil defense organization as being enrolled in that organization,All of these choices are correct
```

And last but certainly not least, the plain text version looks like this:

```
T1A10 (D) [97.3(a)(38), 97.407]
Which of the following describes the Radio Amateur Civil Emergency Service (RACES)? 
A. A radio service using amateur frequencies for emergency management or civil defense communications
B. A radio service using amateur stations for emergency management or civil defense communications
C. An emergency service using amateur operators certified by a civil defense organization as being enrolled in that organization
D. All of these choices are correct

T1A11 (B) [97.101 (d)]
When is willful interference to other amateur radio stations permitted?
A. To stop another amateur station which is breaking the FCC rules
B. At no time 
C. When making short test transmissions
D. At any time, stations in the Amateur Radio Service are not protected from willful interference

```

Note that the correct answer (`(D)`) is coded in the question header along with the question ID
and references to the appropriate regulations.
Also note that there is a blank line after each question, including the last question.

## Why?

I set out to do this work because I wanted to keep track of my progress with
some simple tools of my own.

This project largely overlaps the fine work done by Jason Staten (https://github.com/statianzo)
at https://github.com/statianzo/hampool.

I started doing my version before I found
Jason's. I decided to put this one out there because the version of the General exam question
pool in Jason's repo is now out of date.

In any case, hope someone gets some use from this.

## See Also

[Wikipedia](https://en.wikipedia.org/wiki/Amateur_radio_licensing_in_the_United_States)
has a good introduction to the whole topic of US amateur radio licensing.

The original source of the questions is  [NCVEC](http://www.ncvec.org/page.php?id=338).

[Jason Staten's](https://github.com/statianzo)
fine work is at 
[https://github.com/statianzo/hampool](https://github.com/statianzo/hampool).

You can find online amateur radio testing at https://hamexam.org and https://arrlexamreview.appspot.com.





