function spa --argument env
  test web = (basename $PWD) || return
  if test -z "$env" -a ! -f .env
    set env (string lower -- (string replace --regex '.*@' '' -- $AWS_PROFILE))
    cp ~/.config/env/$env .env
    test -f ~/.config/env/global && cat ~/.config/env/global >> .env
  end    
  test -d node_modules || npm i
  ./node_modules/.bin/nuxt --spa
end
