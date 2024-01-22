function spa -a env
  test web = (basename $PWD) || return
  if test -z "$env"
    if test -f .env
      set env ( string match -g -r '^STAGE=(?<env>\S+)' < .env )
    end
    if test -z "$env"
      #infer stage from aws profile
      set env ( string lower -- ( string replace -r '.*@' '' -- $AWS_PROFILE ) )
    end
  end
  if test -n "$env"
    switch $PWD
    case '*/admin/web'
      cp ~/.config/env/admin/$env .env
    case '*/web'
      cp ~/.config/env/$env .env
    end
    test -f ~/.config/env/global && cat ~/.config/env/global >> .env
  end
  test -d node_modules || npm i --prefer-offline
  if test -x ./node_modules/.bin/nuxi
    ./node_modules/.bin/nuxi dev --spa
  else
    ./node_modules/.bin/nuxt --spa
  end
end
