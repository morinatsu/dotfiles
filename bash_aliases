# ~/.bash_aliases
# Add your custom aliases here.

# 安全対策（上書き・削除前に確認プロンプトを出す）
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# パスを見やすく表示する
alias path='echo -e ${PATH//:/\\n}'
