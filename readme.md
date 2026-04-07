# Ham Radio Question Pool

Amateur radio question pools in various formats.

In the US most anyone can
[get a license](https://www.fcc.gov/wireless/bureau-divisions/mobility-division/amateur-radio-service)
to operate an amateur radio station (i.e. HAM radio) by taking a multiple choice test.
There are no age restrictions and the test questions
are publicly available.

There are actually three tests of increasing difficulty:
* Technician
* General
* Amateur Extra

Passing the technician test means that you get a technician
license which allows you to operate a station in various
specific radio bands, mostly in the VHF and UHF regions of
the radio spectrum.

Passing the general test in addition to the technician
test gives you access to more frequencies while passing
the amateur extra test gives you even more.

You do need to pass the tests in order, first technician,
then general, then amateur extra, but there's no requirement
that you keep going - you can stop at technician or general.

In any case, while the questions are publicly available at
[NCVEC](https://www.ncvec.org/), they are delivered
in Word or PDF format. This project aims to make the questions
available in various machine readable formats, including:
* JSON
* YAML
* CSV
* Simple plain text

## Usage

You can find the data files for the various tests in subdirectories, currently:

* technician-2026-2030
* general-2023-2027	
* extra-2024-2028

The JSON version looks like this:

```json
[
  {
    "id": "T1A01",
    "correct": 2,
    "refs": "[97.1]",
    "question": "Which of the following is part of the Basis and Purpose of the Amateur Radio Service?",
    "answers": [
      "Providing personal radio communications for as many citizens as possible",
      "Providing communications for international contesting",
      "Advancing skills in the technical and communication phases of the radio art",
      "All these choices are correct"
    ],
    "figure": "",
    "correct_letter": "C"
  },

  //...
]
```
Note that the *correct answer index is zero* based, so that the
correct answer to question `T1A01` is the third one,
_Advancing skills in the technical and communication phases of the radio art_. Also note that the `correct` and `correct_letter` fields
encode exactly the same information. The `figure` field is only
populated for questions that refer to a figure. If there is a
value in the `figure` field, it's the file name of a file containing
an image of the figure.

Given all that, the YAML version is about what you would expect:

```yaml
---
- id: T1A01
  correct: 2
  refs: '[97.1]'
  question: Which of the following is part of the Basis and Purpose of the Amateur
    Radio Service?
  answers:
  - Providing personal radio communications for as many citizens as possible
  - Providing communications for international contesting
  - Advancing skills in the technical and communication phases of the radio art
  - All these choices are correct
  figure: ''
  correct_letter: C

```

And the CSV:

```
id,correct,question,refs,a,b,c,d,figure,correct_letter
T1A01,2,Which of the following is part of the Basis and Purpose of the Amateur Radio Service?,[97.1],Providing personal radio communications for as many citizens as possible,Providing communications for international contesting,Advancing skills in the technical and communication phases of the radio art,All these choices are correct,,C
T
...
```

And last but certainly not least, the plain text version looks like this:

```
T1A01 (C) [97.1]
Which of the following is part of the Basis and Purpose of the Amateur Radio Service?
A. Providing personal radio communications for as many citizens as possible
B. Providing communications for international contesting
C. Advancing skills in the technical and communication phases of the radio art
D. All these choices are correct
...
```

The plain text version is more human oriented: The correct answer
index is missing as is the figure reference.
Note that the correct answer (`(C)`) is coded in the question header along with the question ID and references to the appropriate regulations.
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





