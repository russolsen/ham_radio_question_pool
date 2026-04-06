#!/usr/bin/env python

from dataclasses import dataclass

@dataclass
class Question:
    id: int
    correct: int
    refs: str
    question: str
    answers: list
    figure: str

    @classmethod
    def increment_class_variable(cls, v):
        return cls(v['id'],
                   v['correct'],
                   v['refs'],
                   v['question'],
                   v['answers'],
                   v['figure'])

    def correct_letter(self):
        return ['A', 'B', 'C', 'D'][self.correct]

    def to_generic_map(self):
        return {"id": self.id,
                "correct": self.correct,
                "refs": self.refs,
                "question": self.question,
                "answers": self.answers,
                "figure": self.figure,
                "correct_letter": self.correct_letter()}

    def to_csv_map(self):
        return {"id": self.id,
                "correct": self.correct,
                "question": self.question,
                "refs": self.refs,
                "a": self.answers[0],
                "b": self.answers[1],
                "c": self.answers[2],
                "d": self.answers[3],
                "figure": self.figure,
                "correct_letter": self.correct_letter()}


