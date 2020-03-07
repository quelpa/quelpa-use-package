;;; quelpa-use-package.el --- quelpa handler for use-package

;; Copyright 2015, Steckerhalter

;; Author: steckerhalter
;; URL: https://github.com/quelpa/quelpa-use-package
;; Version: 0.0.1
;; Package-Requires: ((emacs "25.1") (quelpa "0") (use-package "2"))
;; Keywords: package management elpa use-package

;; This file is not part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; quelpa handler for `use-package'
;; See the the repo website for more info:
;; https://github.com/quelpa/quelpa-use-package

;;; Requirements:

;; Emacs 25.1, `quelpa' and `use-package'

;;; Code:

(defvar quelpa-use-package-inhibit-loading-quelpa nil
  "If non-nil, `quelpa-use-package' will do its best to avoid
loading `quelpa' unless necessary. This improves performance, but
can prevent packages from being updated automatically.")

(require 'cl-lib)
(unless quelpa-use-package-inhibit-loading-quelpa
  (require 'quelpa))
(require 'use-package-core)

(defvar quelpa-use-package-keyword :quelpa)

;; insert `:quelpa' keyword after `:unless' so that quelpa only runs
;; if either `:if', `:when', `:unless' or `:requires' are satisfied
(defun quelpa-use-package-set-keyword ()
  (unless (member quelpa-use-package-keyword use-package-keywords)
    (setq use-package-keywords
          (let* ((pos (cl-position :unless use-package-keywords))
                 (head (cl-subseq use-package-keywords 0 (+ 1 pos)))
                 (tail (nthcdr (+ 1 pos) use-package-keywords)))
            (append head (list quelpa-use-package-keyword) tail)))))

(defun use-package-normalize/:quelpa (name-symbol keyword args)
  (let ((arg (car args)))
    (pcase arg
      ((or `nil `t) (list name-symbol))
      ((pred symbolp) args)
      ((pred listp) (cond
                     ((listp (car arg)) arg)
                     ((string-match "^:" (symbol-name (car arg))) (cons name-symbol arg))
                     ((symbolp (car arg)) args)))
      (_ nil))))

(defun use-package-handler/:quelpa (name-symbol keyword args rest state)
  (let ((body (use-package-process-keywords name-symbol rest state)))
    ;; This happens at macro expansion time, not when the expanded code is
    ;; compiled or evaluated.
    (if args
        (use-package-concat
         `((unless (and quelpa-use-package-inhibit-loading-quelpa
                        (package-installed-p ',(pcase (car args)
                                                 ((pred symbolp) (car args))
                                                 ((pred listp) (car (car args))))))
             (apply 'quelpa ',args)))
         body)
      body)))

(defun quelpa-use-package-override-:ensure (func name-symbol keyword ensure rest state)
  (let ((ensure (if (plist-member rest :quelpa)
                    nil
                  ensure)))
    (funcall func name-symbol keyword ensure rest state)))

(defun quelpa-use-package-activate-advice ()
  (advice-add
   'use-package-handler/:ensure
   :around
   #'quelpa-use-package-override-:ensure))

(defun quelpa-use-package-deactivate-advice ()
  (advice-remove
   'use-package-handler/:ensure
   #'quelpa-use-package-override-:ensure))

;; register keyword on require
(quelpa-use-package-set-keyword)

(provide 'quelpa-use-package)

;;; quelpa-use-package.el ends here
