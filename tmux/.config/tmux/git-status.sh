#!/bin/env bash

cd $1
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
STATUS=$(git status --porcelain 2>/dev/null| egrep "^(M| M)" | wc -l)
if test "$BRANCH" != ""; then
  if test "$STATUS" = "0"; then
    echo "#[fg=#15161E,bg=#9ece6a,bold]  $BRANCH "
  else
    echo "#[fg=#15161E,bg=#f7768e,bold]  $BRANCH "
  fi
fi
