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
