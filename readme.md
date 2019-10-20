# question_pool

Amateur radio question pools in various formats.

In the US most anyone can
[get a license](https://www.fcc.gov/wireless/bureau-divisions/mobility-division/amateur-radio-service)
to operate an amateur radio station by taking a multiple choice test.
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
[NCVEC](http://www.ncvec.org/page.php?id=338), they are delivered
in Word or PDF format. This project aims to make the questions
accessable in various machine readable formats, including:
* JSON
* YAML
* CSV
* Simple plain text

## Usage

*WARNING: While I have done my best to spot check the data provided here, I am still in the process of wading through all of this and there may be errors!*

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
Note that the correct answer index is *zero* based.

Given that the YAML version is about what you would expect:

```yaml
---
- :id: E1A01
  :correct: 3
  :question: When using a transceiver that displays the carrier frequency of phone
    signals, which of the following displayed frequencies represents the highest frequency
    at which a properly adjusted USB emission will be totally within the band?
  :answers:
  - The exact upper band edge
  - 300 Hz below the upper band edge
  - 1 kHz below the upper band edge
  - 3 kHz below the upper band edge
-
```

And the CSV:

```
id,correct,question,a,b,c,d
T1A01,2,Which of the following is a purpose of the Amateur Radio Service as stated in the FCC rules and regulations?,Providing personal radio communications for as many citizens as possible,Providing communications for international non-profit organizations,Advancing skills in the technical and communication phases of the radio art,All of these choices are correct
T1A02,2,Which agency regulates and enforces the rules for the Amateur Radio Service in the United States?,FEMA,Homeland Security,The FCC,All of these choices are correct
T1A03,3,What are the FCC rules regarding the use of a phonetic alphabet for station identification in the Amateur Radio Service?,It is required when transmitting emergency messages,It is prohibited,It is required when in contact with foreign stations,It is encouraged
```

And last but certainly not least, the plain text version looks like this:

```
8 T1A02 (C) [97.1]
Which agency regulates and enforces the rules for the Amateur Radio Service in the United States?
A. FEMA
B. Homeland Security
C. The FCC
D. All of these choices are correct

T1A03 (D) [97.119(b)(2)]
What are the FCC rules regarding the use of a phonetic alphabet for station identification in the Amateur Radio Service?
A. It is required when transmitting emergency messages
B. It is prohibited
C. It is required when in contact with foreign stations
D. It is encouraged

```

Note that there is a blank line after each question, including the last question.

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

Jason Staten's fine work is at  (https://github.com/statianzo) at https://github.com/statianzo/hampool.

You can find online amateur radio testing at https://hamexam.org and https://arrlexamreview.appspot.com.





