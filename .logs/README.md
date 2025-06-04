# Logs

## zsh history

Inspired by this [article](https://spin.atomicobject.com/log-your-zsh-history/)

> By adding the following to my `.zshrc` file, I was able to reproduce the same functionality I had in `bash`.

```bash
preexec () {
    local fmt_date="$(date +'%Y-%m-%d.%H:%M:%S')" >& /dev/null
    echo "${fmt_date} \"${PWD}\" $1" >> ~/.logs/zsh-history-$(date "+%Y-%m-%d").log
}
```
