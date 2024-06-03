#!/bin/bash

echo "Lines of added and removed by each author in the last month:"

# Get commit statistics for the last month
git log --since="1 month ago" --pretty=format:"%an" --numstat |
awk '
{
  if ($1 ~ /^[0-9]+$/ && $2 ~ /^[0-9]+$/) {
    added[author] += $1;
    removed[author] += $2;
  } else {
    author = $0;
  }
}
END {
  for (author in added) {
    printf "%s: +%d, -%d\n", author, added[author], removed[author];
  }
}' | sort -t: -k2 -nr
