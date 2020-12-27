from Company import Company

class Person:

  def __init__(self):
    self._name = "Tom"
    self._age = 5
    self.company = Company()

  @property
  def name(self):
    return self._name

  @name.setter
  def name(self, newName):
    self._name = newName

  @property
  def age(self):
    return str(self._age)

  @age.setter
  def age(self, newAge):
    self._age = newAge

  def displayPerson(self):
    return "name: " + self.name + ", age: " + self.age

