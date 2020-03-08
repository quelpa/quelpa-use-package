;; bootstrap quelpa
(setq package-archives nil)
(package-initialize)
(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

;; install use-package
(quelpa 'use-package)

;; require the library
(add-to-list 'load-path top-dir)
(require 'quelpa-use-package)

;; test some installs
(use-package grandshell-theme :quelpa)
(use-package ipretty :quelpa t)
(use-package flx-ido :quelpa (:stable t))
(use-package flx-ido :quelpa ((flx-ido) :upgrade t))
(use-package git-modes :quelpa (git-modes :fetcher github :repo "magit/git-modes"))
(use-package git-timemachine :quelpa ((git-timemachine :fetcher gitlab :repo "pidu/git-timemachine") :stable t))
(use-package git-timemachine :quelpa ((git-timemachine :fetcher gitlab :repo "pidu/git-timemachine") :upgrade t))

;; test advice
(setq use-package-always-ensure t)
(quelpa-use-package-activate-advice)
(use-package kite-mini
  :quelpa (kite-mini :fetcher github :repo "tungd/kite-mini.el"))
(quelpa-use-package-deactivate-advice)

;; test ensure
(setq use-package-ensure-function 'quelpa)
(setq use-package-always-ensure nil)
(use-package abc-mode :ensure t)
(setq use-package-always-ensure t)
(use-package elisp-slime-nav)

;; show us the cache
(require 'pp)
(pp quelpa-cache)
