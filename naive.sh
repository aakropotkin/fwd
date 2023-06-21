#! /usr/bin/env bash
echo "Starting \`fwd' ( naive )";
nix --version;
nix registry list;
while :; do
  mapfile -t flakes < <( nix registry list; );
  for l in "${flakes[@]}"; do
    owner="${l%% *}";
    uri="${l##* }";
    echo "Scraping: '$uri'";
    nix flake show --json "$uri" --all-systems >/dev/null 2>&1;
    echo "Done:     '$uri'";
  done
  TZ= date;
  echo 'Sleeping for 60 seconds';
  sleep 60;
done
