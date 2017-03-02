#!/usr/bin/env python3


import sys


HELP = '''Examples

  Brightness

    % theme-switch toggle
    % theme-switch dark
    % theme-switch light


  Schemas

    % theme-switch schema[s]
    default
    ...
    % theme-switch schema <SCHEMA>

'''
class Error(Exception):

    def __init__(self, exit_code, message):
        super(Error, self).__init__(message)
        self.exit_code = exit_code


def UsageError(message):
     return Error(2, message)


def main(args):

    if len(args) == 1 and args[0] in ["toggle", "dark", "light"]:
        # TODO
        print ("Set brightness to: " + args[0])

    elif len(args) == 1 and args[0] == "schema":
        # TODO
        print ("List schemas")

    elif len(args) == 2 and args[0] == 'schema':
        # TODO
        print ("Set schema to: " + args[1])

    else:
        print(HELP)
        raise UsageError("Wrong arguments.")



if __name__ == "__main__":
    args = sys.argv[1:]

    if "--help" in ''.join(args):
        print(HELP)
    else:
        try:
            main(args)
        except Error as e:
            print('ERROR: ' + str(e))
            sys.exit(e.exit_code)
