#!/bin/bash
if ps aux|grep erlproto|grep -v grep >/dev/null 2>&1
  then
     rebar ct -r -v skip_deps=true
  else
     /Users/ginahagg/mywork/homework/erlproto/rel/erlproto/bin/erlproto start && rebar ct -r -v skip_deps=true
fi
