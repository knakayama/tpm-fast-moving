-tpm-fast-moving() {
  local i
  for i in "peco" "tmux"; do
    if ! type "$i" &>/dev/null; then
      cat <<EOT 1>&2
$i does not found in your \$PATH.
EOT
    return 1
    fi
  done

  if [[ -z "$TMUX_PLUGIN_MANAGER_PATH" ]]; then
    cat <<'EOT' 1>&2
$TMUX_PLUGIN_MANAGER_PATH is not set, tpm does not work properly on your machine?
EOT
  return 1
  fi

  # old version tpm compatibility
  cd $(ls -1d $TMUX_PLUGIN_MANAGER_PATH* \
    | grep "$(tmux show-options -gqv @tpm_plugins \
      | tr ' ' '\n' \
      | cut -d/ -f2 \
      | awk '/[:alnum:]/ {print}' \
      | xargs -I% echo ${TMUX_PLUGIN_MANAGER_PATH}%)" \
    | peco
  )
  zle accept-line
  zle -R -c
}

autoload -Uz -- -tpm-fast-moving
zle -N -- -tpm-fast-moving

# Local Variables:
# mode: Shell-Script
# sh-indentation: 2
# indent-tabs-mode: nil
# sh-basic-offset: 2
# End:
# vim: ft=zsh sw=2 ts=2 et
