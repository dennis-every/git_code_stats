#!/bin/bash

# Print the header
echo "Number of commits by each author in the last month:"

# Get commit statistics for the last month
git log --since="1 month ago" --pretty=format:"%an" |
awk '
{
  author_count[$0] += 1;
}
END {
  for (author in author_count) {
    printf "%s: %d\n", author, author_count[author];
  }
}' | sort -t: -k2 -n
