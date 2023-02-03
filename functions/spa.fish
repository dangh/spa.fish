function spa -a env
  test web = (basename $PWD) || return
  if test -z "$env" -a ! -f .env
    #infer stage from aws profile
    set env (string lower -- (string replace -r '.*@' '' -- $AWS_PROFILE))
  end
  if test -n "$env"
    cp ~/.config/env/$env .env
    test -f ~/.config/env/global && cat ~/.config/env/global >> .env
  end
  test -d node_modules || npm i --prefer-offline
  if test -x ./node_modules/.bin/nuxi
    ./node_modules/.bin/nuxi dev --spa
  else
    ./node_modules/.bin/nuxt --spa
  end
end
