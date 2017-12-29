# dotemacs

A lean setup for Clojurians.

Based on https://gitlab.com/nilenso/dotemacs and some additions.


## Installation

0. Install Emacs
  1. OSX: https://emacsformacosx.com/ or `brew install emacs --with-cocoa`
  2. Windows: Download from https://www.gnu.org/software/emacs/download.html
  3. Linux: Use the OS package manager
1. Backup and remove any existing `~/.emacs.d` directory.
2. Run `git clone https://github.com/kumarshantanu/dotemacs ~/.emacd.d`
3. Starts Emacs and let it download and setup everything.


## Customization

Create a file `init-user.el` file with custom changes.

If you do not want whitespace markers, put the following to `init-user.el`:

```clojure
(global-whitespace-mode 0)
```


## Usage

Shrink contiguous whitespace into single space: `C-M-SPC` (Ctrl+Alt+Space)

Show/hide NeoTree: `F8` (`F9` to refresh)

Close current buffer and window: `s-w` (Cmd+w)

Projectile help page: `C-c p C-h`
