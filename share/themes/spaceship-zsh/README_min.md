#### Spaceship ZSH

![Spaceship](https://user-images.githubusercontent.com/10276208/36086434-5de52ace-0ff2-11e8-8299-c67f9ab4e9bd.gif)

Spaceship is a minimalistic, powerful and extremely customizable Zsh prompt. It combines everything you may need for convenient work, without unnecessary complications, like a real spaceship.

Currently it shows:

- Clever hostname and username displaying.
- Prompt character turns red if the last command exits with non-zero code.
- Current Git branch and rich repo status:
  - `?` — untracked changes;
  - `+` — uncommitted changes in the index;
  - `!` — unstaged changes;
  - `»` — renamed files;
  - `✘` — deleted files;
  - `$` — stashed changes;
  - `=` — unmerged changes;
  - `⇡` — ahead of remote branch;
  - `⇣` — behind of remote branch;
  - `⇕` — diverged chages.
- Current Mercurial branch and rich repo status:
  - `?` — untracked changes;
  - `+` — uncommitted changes in the index;
  - `!` — unstaged changes;
  - `✘` — deleted files;
- Indicator for jobs in the background (`✦`).
- Current Node.js version, through nvm/nodenv/n (`⬢`).
- Current Ruby version, through rvm/rbenv/chruby (`💎`).
- Current Elixir version, through kiex/exenv/elixir (`💧`).
- Current Swift version, through swiftenv (`🐦`).
- Current Xcode version, through xenv (`🛠`).
- Current Go version (`🐹`).
- Current PHP version (`🐘`).
- Current Rust version (`𝗥`).
- Current version of Haskell Tool Stack (`λ`).
- Current Julia version (`ஃ`).
- Current Docker version and connected machine (`🐳`).
- Current Amazon Web Services (AWS) profile (`☁️`) ([Using named profiles](http://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html)).
- Current Python virtualenv.
- Current Conda virtualenv (`🅒`).
- Current Python pyenv (`🐍`).
- Current .NET SDK version, through dotnet-cli (`.NET`).
- Current Ember.js version, through ember-cli (`🐹`).
- Current Kubectl context (`☸️`).
- Package version, if there's is a package in current directory (`📦`).
- Current battery level and status:
  - `⇡` - charging;
  - `⇣` - discharging;
  - `•` - fully charged.
- Current Vi-mode mode (with handy aliases for temporarily enabling).
- Optional exit-code of last command.
- Optional time stamps 12/24hr in format.
- Execution time of the last command if it exceeds the set threshold.

source: [denysdovhan/spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt)  
docs: [denysdovhan.com/spaceship-prompt](https://denysdovhan.com/spaceship-prompt)  
