#!/usr/bin/env python
# Decantor: A JSON to CSV converter
# =============================================================================
#
# The MIT License
#
# Copyright (c) 2011, Michael Van Veen, and Gettaround, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

import json
import re
import sys
from itertools import chain, izip_longest
from unicodewriter import UnicodeWriter as csv
from csv import QUOTE_ALL
from pprint import pprint


class JSONToCSV(object):
  typecheck = lambda self, x: (isinstance(x, dict) or isinstance(x, list))

  def __init__(self, filestr):
    lines = open(filestr, 'r').readlines()
    self.json         = [json.loads(line) for line in lines]
    self._symbolTable = self.getSymbolTable()
    self._rows        = self.readRows()
    self._columns     = self.scrubColumns(self._symbolTable, self._rows)

  def grabKeys(self, obj, stack=[], keys={}):
   '''Recursively grabs a list of json object key strings.

      Format is 'parent.child' for all nested keys.
   '''

   childKeys = {}
   if isinstance(obj, dict):
     keys = dict(
                chain([(x,                     True) for x in keys.iterkeys()]
                      + [('.'.join(stack + [y]), True) for y in obj.iterkeys()]
                       ))
     childKeys = [[ x for x in self.grabKeys( y[1],
                                                stack + [y[0]],
                                                keys).iteritems()
                    ] for y in filter(
                                lambda x: self.typecheck(x[1]),
                                obj.iteritems()
                              )]
     childKeys = dict(chain.from_iterable(childKeys))

   elif isinstance(obj, list):
     childKeys = [[x for x in self.grabKeys(item, stack, keys).iteritems()]
                     for item in filter(lambda x: self.typecheck(x), obj)
                 ]
     childKeys = dict(chain.from_iterable(childKeys))

   return(dict(
          chain(childKeys.iteritems(), keys.iteritems())))

  def getSymbolTable(self):
   '''Returns an iterator of all keys within the json diagonalization.
   '''
   return(sorted(self.grabKeys(self.json).iterkeys()))

  def readObj(self, obj):
    '''Parses a list of json objects. Returns a diagonalization of all objects.
    '''
    assert(self._symbolTable)
    keys = dict((x, [obj] + x.split('.')) for x in self.grabKeys(obj))
    if isinstance(obj, list):
      assert(len(obj) == 1)
      obj = obj.pop()

    assert(isinstance(obj, dict))
    # objs returns a dictionary where iterated items (key, value),
    # where key, value are the key as concatenated by self.grabKeys() and its
    # value from within the object, respectively

    objs = dict(
           [(key,
              reduce(lambda x, y: \
                      ((isinstance(x, list))
                          and len(x) and x.pop().get(y)
                      ) or (isinstance(x, dict) and x.get(y))
                        or x, stack)
              ) for key, stack in keys.iteritems()
            ])

    # This is how we build a row
    return [(( objs.has_key(x)
                 and not(self.typecheck(objs[x]))) and unicode(objs[x])
            ) or ' ' for x in self._symbolTable]

  def readRows(self):
    '''Returns all the csv rows for an object.

       Rows include cells with empty values that are ulimately scrubbed later.

       >>> jsonrows = JSONToCSV('tests/test2.json').readRows()
       >>> assert([x for x in jsonrows] == [[u'', u'', u'lol'], [u'', u'', u'lol']])
    '''
    # Only works on lists of json objects
    assert(self.json)
    assert(isinstance(self.json, list))

    rv = (self.readObj(x) for x in self.json)
    return rv

  def scrubColumns(self, symbolTable, columns):
    '''Removes empty columns from the output.

       >>> json = JSONToCSV('tests/test2.json')
       >>> assert(json.scrubColumns(json.getSymbolTable(), json.readRows()) \
                    == {u'a.b.c': (u'lol', u'lol')}
                 )
    '''
    columnDict = dict(zip(symbolTable, zip(*columns)))

    return(dict(
            [(key, column)
               for key, column in columnDict.iteritems()
                  if filter(None, column)
          ]))

  def writeToFile(self, filename):
    assert(self._columns)

    with open(filename, 'wb') as outfile:
      csvObj = csv(outfile, dialect='excel', quoting=QUOTE_ALL)
      csvObj.writerow([x for x in self._columns.iterkeys()])
      #pprint([len(x) for x in izip_longest(*self._columns.itervalues())])
      map(lambda row: \
              csvObj.writerow([re.sub(r'\r\n', '', cell) for cell in row]),
            izip_longest(*self._columns.itervalues()))

      #csvObj.writerows(self.readObj(self.json[4]))


if __name__ == "__main__":
  jsonobj = JSONToCSV(sys.argv[1]).writeToFile(sys.argv[2])
