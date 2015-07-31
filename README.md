# quelpa-use-package.el

If you are using [use-package](https://github.com/jwiegley/use-package) (which can help to simplify your .emacs) you can use the `quelpa` handler provided by `quelpa-use-package.el`.

Assuming you have bootstrapped `quelpa` and installed `use-package` probably like this:

```cl
(quelpa '(use-package :fetcher github :repo "jwiegley/use-package" :files ("use-package.el")))
```

To use the `:quelpa` keyword with `use-package`, require the library:

```cl
(require 'quelpa-use-package)
```

then it's possible to call `use-package` with all kinds of arguments:

```cl
(use-package abc-mode :quelpa) ;installs abc-mode with quelpa
(use-package abc-mode :quelpa t) ;does the same
(use-package abc-mode :quelpa abc-mode) ;again... (if the package would have another name)
(use-package abc-mode :quelpa (:upgrade t)) ;passes upgrade parameter to quelpa
(use-package abc-mode :quelpa (abc-mode :fetcher github :repo "mkjunker/abc-mode")) ;uses recipe
(use-package abc-mode :quelpa ((abc-mode :fetcher github :repo "mkjunker/abc-mode") :upgrade t)) ;recipe with plist arguments
```
