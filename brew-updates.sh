#!/bin/bash

outdated_brews=$(/usr/local/bin/brew outdated | wc -l | tr -d -c '0-9')

outdated_casks=$(/usr/local/bin/brew cask outdated | wc -l | tr -d -c '0-9')

if [ ${outdated_brews} -gt 0 ] || [ ${outdated_casks} -gt 0 ]; then
  symbols_to_show=":fire::fire::fire:"
fi

echo "${symbols_to_show}Outdated brews:${outdated_brews} casks:${outdated_casks}${symbols_to_show}"
