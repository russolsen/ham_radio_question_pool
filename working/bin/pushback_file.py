#!/usr/bin/env python

class PushbackFile:
  def __init__(self, file_obj):
    self.file_obj = open(file_obj)
    self.pushback_stack = []

  def readline(self):
    # Always check the stack first
    if self.pushback_stack:
      return self.pushback_stack.pop()
    return self.file_obj.readline()

  def pushback(self, line):
    self.pushback_stack.append(line)

  def iseof(self):
    if self.pushback_stack:
      #print("Not eof, stuff onstack")
      return False
    position = self.file_obj.tell()
    if self.file_obj.read(1):
      self.file_obj.seek(position)
      return False
    return True

  def __iter__(self):
    return self

  def __next__(self):
    line = self.readline()
    if not line:
      raise StopIteration
    return line

  def __enter__(self):
    return self

  def __exit__(self, exc_type, exc_value, traceback):
    # Ensure the file we are wrapping gets closed
    self.file_obj.close()


