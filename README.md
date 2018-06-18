<a href="https://framagit.org/steckerhalter/quelpa"><img align="right" src="https://framagit.org/steckerhalter/quelpa/raw/master/logo/quelpa-logo-h64.png"></a>
# quelpa-use-package

**Note:** repo is now on [framagit.org](https://framagit.org/steckerhalter/quelpa-use-package), github is just a mirror

If you are using [use-package](https://github.com/jwiegley/use-package) (which can help to simplify your .emacs) you can use the [quelpa](https://framagit.org/steckerhalter/quelpa) handler provided by `quelpa-use-package`.

## Installation

**Requirements**: Emacs 24.3

Assuming you have bootstrapped `quelpa`, install `quelpa-use-package` (which installs `use-package` as a dependency) and require the library:

```cl
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://framagit.org/steckerhalter/quelpa-use-package.git"))
(require 'quelpa-use-package)
```

## Usage

After that it is possible to call `use-package` with the `:quelpa` keyword:

```cl
;; installs abc-mode with quelpa
(use-package abc-mode :quelpa)

;; does the same (`t' is optional)
(use-package abc-mode :quelpa t)

;; again... (if the package would have another name)
(use-package abc-mode :quelpa abc-mode)

;; passes upgrade parameter to quelpa
(use-package abc-mode :quelpa (:upgrade t))

;; uses the given recipe
(use-package abc-mode
  :quelpa (abc-mode :fetcher github :repo "mkjunker/abc-mode"))

;; recipe with plist arguments
(use-package abc-mode
  :quelpa ((abc-mode :fetcher github :repo "mkjunker/abc-mode") :upgrade t))
```

### Using quelpa with `:ensure`

To make `:ensure t` use `quelpa` instead of `package.el` set the `use-package-ensure-function` in your init file:

```cl
(setq use-package-ensure-function 'quelpa)
```

After that:

```cl
(use-package abc-mode :ensure t)
```

will install `abc-mode` with `quelpa`.

And if you enable `use-package-always-ensure`:

``` cl
(setq use-package-always-ensure t)
```

then

``` cl
(use-package abc-mode)
```

will install `abc-mode` with `quelpa`.

### Conditional execution

Note that the `:quelpa` keyword is inserted after `:if`, `:when`, `:unless` and `:requires` so that you can make the installation of a package depend on some requirement, for example:

```cl
(use-package magit-filenotify
  :when (fboundp 'file-notify-add-watch)
  :quelpa (magit-filenotify :fetcher github :repo "magit/magit-filenotify")
```

In this case `magit-filenotify` is only installed if the function `file-notify-add-watch` is bound.

Likewise you can use `:requires` to make the installation depend on a feature being available:

```cl
(use-package magit-filenotify
  :requires filenotify
  :quelpa (magit-filenotify :fetcher github :repo "magit/magit-filenotify"))
```

### Overriding `use-package-always-ensure`

To install some packages with quelpa but use `use-package-always-ensure` to install all others from an ELPA repo `:ensure` needs to be disabled if the `:quelpa` keyword is found.

`quelpa-use-package` provides an advice for this purpose which can be activated thus:

```cl
(quelpa-use-package-activate-advice)
```

To disable it again you can use:

```cl
(quelpa-use-package-deactivate-advice)
```
