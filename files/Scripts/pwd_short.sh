#!/bin/bash

# strip pwd to current directory

pwd | rev | cut -d'/' -f-1 | rev
