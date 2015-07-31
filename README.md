[![Home](https://raw.github.com/quelpa/quelpa/master/logo/quelpa-logo-h64.png)](https://github.com/quelpa/quelpa)
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

Note that that the `:quelpa` keyword is added right after `:disabled` so it has preference over any other `use-package` keyword (which makes kind of sense because to do something with a package you first need to have it installed :)
