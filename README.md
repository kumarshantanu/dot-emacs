# dotemacs

A lean setup for Clojurians.

Based on https://gitlab.com/nilenso/dotemacs and some additions and changes.


## Installation

0. Install Emacs
    - OSX: https://emacsformacosx.com/ or run `brew install emacs --with-cocoa`
    - Windows: Download from https://www.gnu.org/software/emacs/download.html
    - Linux: Use the OS package manager
1. Backup and remove any existing `~/.emacs.d` directory.
2. Run `git clone https://github.com/kumarshantanu/dotemacs.git ~/.emacd.d`
3. Starts Emacs and let it download and setup everything.


## Customization

Create a file `init-user.el` file with custom changes.

If you do not want whitespace markers, put the following to `init-user.el`:

```elisp
(global-whitespace-mode 0)
```


## Usage

Shrink contiguous whitespace into single space: `C-M-SPC` (Ctrl+Alt+Space)

Show/hide NeoTree: `F8` (`F9` to refresh)

Close current buffer and window: `s-w` (Cmd+w)

Projectile help page: `C-c p C-h`

### CIDER/nREPL connection

To connect via [Cider](https://cider.readthedocs.io/en/latest/) add the following
entry (update versions as appropriate) in `~/.lein/profiles.clj` file:

```clojure
:repl {:plugins [[cider/cider-nrepl "0.16.0"]
                 [refactor-nrepl    "2.3.1"]]}
```

**Note:**
This entry has `:repl` as the key, so that it is used only with a REPL,
and does not slow down other Leiningen tasks.

If the file `~/.lein/profiles.clj` does not exist already, then create one with the
following content (update versions as appropriate):

```clojure
{:repl {:plugins [[cider/cider-nrepl "0.16.0"]
                  [refactor-nrepl    "2.3.1"]]}}
```
