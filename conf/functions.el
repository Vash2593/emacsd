;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define helper function ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(package-initialize)
(require 'package) ;; System package
(defun require-or-install (package)
  "Install the package if needed and require it."
  (progn
    (if (not (package-installed-p package)) (package-install package))
    (require 'package)))
