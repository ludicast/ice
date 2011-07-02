linkTo = (label, link, opts) ->
  if (! link)
    link = label
  a href:link, -> label

navBar = (args...)->
  if args.length == 2
    opts = args.shift()
  else
    opts = {}
  f = args[0]

  navWrap = opts.navWrap || ul
  linkWrap = opts.linkWrap || li

  methods =
    linkTo: (name, href)->
      if (! href)
        href = name
      linkWrap -> linkTo name, href

  navWrap ->
    f(methods)