# question_pool

> Amateur radio question pools various formats formats

Questions are available in:
* JSON
* YAML
* CSV
* Simple plain text

## Usage

WARNING: While I have done my best to spot check the data provided here,
I am still in the process of wading through all of this and there may
be errors!

The JSON version looks like this:

```json
[
  ...
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
  },
  ...
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

## Why?

This project largely overlaps the fine work done by Jason Staten (https://github.com/statianzo)
at https://github.com/statianzo/hampool.

I started doing my version before I found
Jason's. I decided to put this one out there because the version of the General exam question
pool in Jason's repo is now out of date.

As Jason says, doing sort of thing is necessary because:

> The amateur radio question pools made [available by NCVEC](http://www.ncvec.org/page.php?id=338) aren't available in an easily
> consumable format...

In any case, hope someone gets some use from this.

