# dot-emacs

A lean setup for Clojurians.

Based on https://gitlab.com/nilenso/dotemacs and some additions and changes.


## Installation

0. Install Emacs
    - OSX: https://emacsformacosx.com/ or run `brew install emacs --with-cocoa`
    - Windows: Download from https://www.gnu.org/software/emacs/download.html
    - Linux: Use the OS package manager
1. Backup and remove any existing `~/.emacs.d` directory.
2. Run `git clone https://github.com/kumarshantanu/dot-emacs.git ~/.emacs.d`
3. Starts Emacs and let it download and setup everything.


## Customization

Create a file `init-user.el` file with any custom changes, e.g. the following:

```elisp
;; Disable whitespace markers
(global-whitespace-mode 0)

;; Do not save/restore window layout
(desktop-save-mode 0)

;; Disable buffer tabs
(tabbar-mode 0)
```


## Usage

| Description                                    | Shortcut key               |
|------------------------------------------------|----------------------------|
| Shrink contiguous whitespace into single space | `C-M-SPC` (Ctrl+Alt+Space) |
| Delete selected text                 | `C-M-backspace` (Ctrl+Alt+Backspace) |
| Neotree docs: https://github.com/jaypei/emacs-neotree |                     |
| Treemacs show/hide                             | `F4`                       |
| Treemacs refresh from filesystem               | `F5`                       |
| NeoTree show/hide                              | `F8`                       |
| NeoTree refresh from filesystem                | `F9`                       |
| Close current buffer and window                | `s-w` (Cmd+w)              |
| Projectile help (commands work in Git repo)    | `C-c p C-h`                |

### inf-clojure (Enabled by default)

Disable inf-clojure (in `init.el`, only one can be enabled) by commenting out and restarting Emacs:

```elisp
(require 'init-cider)
;; (require 'init-inf-clojure)
```

### CIDER/nREPL connection (Disabled by default)

Enable CIDER (in `init.el`, only one can be enabled) by commenting out and restarting Emacs:

```elisp
(require 'init-cider)
;; (require 'init-inf-clojure)
```


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
