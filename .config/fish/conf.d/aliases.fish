if type -q exa
  alias ls "exa -la --icons --header --group --time-style=long-iso"
end

if type -q nvim
  command -qv nvim && alias vim nvim
end