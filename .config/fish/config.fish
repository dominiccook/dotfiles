
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/dominic/anaconda3/bin/conda
    eval /home/dominic/anaconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/dominic/anaconda3/etc/fish/conf.d/conda.fish"
        . "/home/dominic/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/dominic/anaconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

