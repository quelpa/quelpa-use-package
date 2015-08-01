<a href="https://github.com/quelpa/quelpa"><img align="right" src="https://raw.github.com/quelpa/quelpa/master/logo/quelpa-logo-h64.png"></a>
# quelpa-use-package

[![Build Status](https://travis-ci.org/quelpa/quelpa-use-package.svg?branch=master)](https://travis-ci.org/quelpa/quelpa-use-package)

If you are using [use-package](https://github.com/jwiegley/use-package) (which can help to simplify your .emacs) you can use the [quelpa](https://github.com/quelpa/quelpa) handler provided by `quelpa-use-package`.

Assuming you have bootstrapped `quelpa` and installed `use-package` probably like this:

```cl
(quelpa '(use-package :fetcher github :repo "jwiegley/use-package" :files ("use-package.el")))
```

To use the `:quelpa` keyword with `use-package`, install `quelpa-use-package` and require the library:

```cl
(quelpa '(quelpa-use-package :fetcher github :repo "quelpa/quelpa-use-package"))
(require 'quelpa-use-package)
```

After that it is possible to call `use-package` with the `:quelpa` keyword:

```cl
(use-package abc-mode :quelpa) ;installs abc-mode with quelpa
(use-package abc-mode :quelpa t) ;does the same
(use-package abc-mode :quelpa abc-mode) ;again... (if the package would have another name)
(use-package abc-mode :quelpa (:upgrade t)) ;passes upgrade parameter to quelpa
(use-package abc-mode :quelpa (abc-mode :fetcher github :repo "mkjunker/abc-mode")) ;uses recipe
(use-package abc-mode :quelpa ((abc-mode :fetcher github :repo "mkjunker/abc-mode") :upgrade t)) ;recipe with plist arguments
```

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