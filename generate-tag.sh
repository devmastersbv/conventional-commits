#!/bin/bash
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

TAG=$(git describe --tags)
VERSION=$(echo "$TAG" | grep -o '[0-9]*\.[0-9]*\.[0-9]*')

if [ -z "$TAG" ] || [ -z "$VERSION" ] ; then
  #Not a valid version
  echo "untagged";
  exit 0;
fi

MESSAGES=$(git log $VERSION..HEAD --pretty=oneline --abbrev-commit | awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}')
COUNT=0
MAJOR=$(echo "$VERSION" | cut -d'.' -f1)
MINOR=$(echo "$VERSION" | cut -d'.' -f2)
PATCH=$(echo "$VERSION" | cut -d'.' -f3)
LEVEL=3
function setLevel(){
  [[ $1 < $LEVEL ]] && LEVEL=$1
}

while read -r line; do
  if [[ $(echo "$line" | grep -E '(improvement|fix|feature|feat|performance)(\([^\)]*\))*\!:') ]] || [[ $(echo "$line" | grep 'BREAKING CHANGE:') ]]; then
    ((MAJOR=$(echo "$VERSION" | cut -d'.' -f1)+1))
    setLevel 0
  fi
  if [[ $(echo "$line" | grep -E '(feature|feat|performance|perf)(\([^\)]*\))*:') ]]; then
    ((MINOR=$(echo "$VERSION" | cut -d'.' -f2)+1))
    setLevel 1
  fi
  if [[ $(echo "$line" | grep -E '(improvement|fix)(\([^\)]*\))*:') ]]; then
    ((PATCH=$(echo "$VERSION" | cut -d'.' -f3)+1))
    setLevel 2
  fi
  ((COUNT=COUNT+1))
done <<< "$MESSAGES"

#Reset minor or patch if the parent got incremented
if [ "$LEVEL" -le 1 ]; then
  PATCH=0
fi
if [ $LEVEL == 0 ]; then
  MINOR=0
fi

SHA=""
if [ "$1" == "--sha" ]; then
  SHA="-$(git rev-parse --short HEAD)"
fi

echo "$MAJOR.$MINOR.$PATCH-rc.$COUNT$SHA"
