(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/MyToDo/Project.org" "~/MyToDo/Project_SPM.org" "~/MyToDo/Personal.org")))
 '(safe-local-variable-values (quote ((todo-categories "Work" "Personal")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;;-------------------short key--------------------------
(global-set-key [(meta g)] 'goto-line)

;; todo command
;;(global-set-key [f2] 'todo-done)
;;(global-set-key [f3] 'todo-undo)
;;(global-set-key [f4] 'todo-show)
(global-set-key [f2] 'org-agenda)

(global-set-key [(f5)] 'emacs-wiki-find-file)
(global-set-key [(f6)] 'list-bookmarks)
(global-set-key [(f7)] 'bookmark-set)

;;Ctrl+Space invalid
(global-set-key (kbd "C-SPC")'nil)
;; bash shell
(global-set-key [f1]
		'(lambda ()
		   (interactive)
		   (eshell)))
;;F12 jump to function defination
;;S+F12 back to funciton call

;;-------------maximize window--------
(defun w32-maximize-frame ()
    "Maximize the current frame"
     (interactive)
     (w32-send-sys-command 61488))
;(w32-maximize-frame)

;;----------some windows set---------
(find-file "~/")
(show-paren-mode t)
(setq show-paren-style 'parentheses)
(mouse-avoidance-mode 'animate)
(fset 'yes-or-no-p 'y-or-n-p)
(setq visible-bell t)
(setq inhibit-startup-message t)
(setq column-number-mode t)
;show line num
(global-linum-mode 1)
(blink-cursor-mode -1)
(transient-mark-mode 1)
(global-font-lock-mode t)
(setq frame-title-format "emacs@%b")
(setq user-full-name "Sun Chuan")
(setq user-mail-address "art.of.war.sunzi@gmail.com")

;;set background and forward color
(setq default-frame-alist
      '(   (foreground-color . "Wheat")
           (background-color . "DarkSlateGray")
           (cursor-color     . "Orchid")
       ))

(setq display-time-day-and-date t)
(tool-bar-mode nil)
;;(menu-bar-mode nil)
(display-time)

;; chinese environment setting
;(set-language-environment 'Chinese-GBK)
;(set-selection-coding-system 'chinese-gbk)
;(set-terminal-coding-system 'chinese-gbk)
;(set-keyboard-coding-system 'chinese-gbk)
;(set-language-environment 'Chinese-GBK)
;(setq locale-coding-system 'chinese-gbk)
;(setq current-language-environment "Chinese-GBK")
;(set-selection-coding-system 'chinese-gbk)
;(prefer-coding-system 'chinese-gbk)
;(setq file-coding-system-alist
;    (list file-coding-system-alist
;        `(".*" chinese-gbk)))
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'chinese-iso-8bit)
(prefer-coding-system 'chinese-gbk)
(prefer-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;;font setting
(defun qiang-font-existsp (font)
  (if (null (x-list-fonts font))
      nil t))
(defun qiang-make-font-string (font-name font-size)
  (if (and (stringp font-size) 
           (equal ":" (string (elt font-size 0))))
      (format "%s%s" font-name font-size)
    (format "%s %s" font-name font-size)))
(defun qiang-set-font (english-fonts
                       english-font-size
                       chinese-fonts
                       &optional chinese-font-size)
  "english-font-size could be set to \":pixelsize=18\" or a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
  (require 'cl)                         ; for find if
  (let ((en-font (qiang-make-font-string
                  (find-if #'qiang-font-existsp english-fonts)
                  english-font-size))
        (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
                            :size chinese-font-size)))
 
    ;; Set the default English font
    ;; 
    ;; The following 2 method cannot make the font settig work in new frames.
    ;; (set-default-font "Consolas:pixelsize=18")
    ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
    ;; We have to use set-face-attribute
    (message "Set English Font to %s" en-font)
    (set-face-attribute
     'default nil :font en-font)
 
    ;; Set Chinese font 
    ;; Do not use 'unicode charset, it will cause the english font setting invalid
    (message "Set Chinese Font to %s" zh-font)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset
                        zh-font))))
(qiang-set-font
 '("Courier New" "Consolas" "Monaco" "DejaVu Sans Mono" "Monospace") ":pixelsize=16"
 '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))


;; hide and show outline mode
(setq outline-minor-mode-prefix [(control o)])

;;----------------bookmark-----------------------
(setq bookmark-default-file "~/.emacs.d/.emacs.bmk")
(setq bookmark-save-flag 1)

;;-----------------back up--------------
(setq backup-directory-alist (quote (("." . "~/backups"))))
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/backups")))
(setq backup-by-copying t)


;;--------------todo-------------------
(setq todo-file-do "~/.emacs.d/todo-do")
(setq todo-file-done "~/.emacs.d/todo-done")
(setq todo-file-top "~/.emacs.d/todo-top")
(setq diary-file "~/.emacs.d/diary")

;;----------------org mode---------------
;(setq org-hide-leading-stars t) 
(define-key global-map "\C-ca" 'org-agenda) 
(setq org-log-done 'time)

;;----------------wiki-----------------
(add-to-list 'load-path "~/.emacs.d/lisp/emacs-wiki-2.72")
(add-to-list 'load-path "~/.emacs.d/lisp/emacs-wiki-2.72/contrib")
(add-to-list 'load-path "~/.emacs.d/lisp/emacs-wiki-2.72/scripts")
(require 'emacs-wiki)
(require 'emacs-wiki-menu)
(require 'emacs-wiki-srctag)
(require 'emacs-wiki-table)    
(load "~/.emacs.d/lisp/latex2png.el")
(push '("latex" t t t gs-latex-tag) emacs-wiki-markup-tags)
(setq gs-latex2png-scale-factor 1.5)            ;; set pic size

(setq emacs-wiki-projects
        `(("Tool" . ((emacs-wiki-directories . ("~/WiKi/draft/Tool"))
                    (emacs-wiki-publishing-directory . "~/WiKi/publish/Tool")
                    (emacs-wiki-default-page . "../Tool/WelcomePage")))
        ("SoftwareEngineering" . ((emacs-wiki-directories . ("~/WiKi/draft/SoftwareEngineering"))
                    (emacs-wiki-publishing-directory . "~/WiKi/publish/SoftwareEngineering")
                    (emacs-wiki-default-page . "../SoftwareEngineering/WelcomePage")))
        ("Programming" . ((emacs-wiki-directories . ("~/WiKi/draft/Programming"))
                          (emacs-wiki-publishing-directory . "~/WiKi/publish/Programming")
                          (emacs-wiki-default-page . "../Programming/WelcomePage")))
	("Bank" . ((emacs-wiki-directories . ("~/WiKi/draft/Bank"))
		   (emacs-wiki-publishing-directory . "~/WiKi/publish/Bank")
		   (emacs-wiki-default-page . "../Bank/WelcomePage")))
	("DataAnalysis" . ((emacs-wiki-directories . ("~/WiKi/draft/DataAnalysis"))
		   (emacs-wiki-publishing-directory . "~/WiKi/publish/DataAnalysis")
		   (emacs-wiki-default-page . "../DataAnalysis/WelcomePage")))
	("Other" . ((emacs-wiki-directories . ("~/WiKi/draft/Other"))
		   (emacs-wiki-publishing-directory . "~/WiKi/publish/Other")
		   (emacs-wiki-default-page . "../Other/WelcomePage")))
	("MyProject" . ((emacs-wiki-directories . ("~/WiKi/draft/MyProject"))
		    (emacs-wiki-publishing-directory . "~/WiKi/publish/MyProject")
		    (emacs-wiki-default-page . "../MyProject/WelcomePage")))
	("Blog" . ((emacs-wiki-directories . ("~/WiKi/draft/Blog"))
		    (emacs-wiki-publishing-directory . "~/WiKi/publish/Blog")
		    (emacs-wiki-default-page . "../Blog/WelcomePage")))        
        ("Default" . ((emacs-wiki-directories . ("~/WiKi/draft/default"))
                      (emacs-wiki-publishing-directory . "~/WiKi/publish/Default")
                      (emacs-wiki-default-page . "../Default/WelcomePage")))))
      

(setq emacs-wiki-index-page  "../WiKiIndex.html")
(setq emacs-wiki-directories '("~/WiKi/draft"))
(setq emacs-wiki-publishing-directory "~/WiKi/publish")
(setq emacs-wiki-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/core.css\">")
(setq emacs-wiki-meta-charset "utf-8") 
(setq emacs-wiki-meta-content-coding "utf-8")
(setq emacs-wiki-charset-default "utf-8")
(setq emacs-wiki-coding-default "utf-8")
(setq emacs-wiki-maintainer "mailto:art.of.war.sunzi@gmail.com")
(setq emacs-wiki-inline-relative-to 'emacs-wiki-publishing-directory)

(defun emacs-wiki-preview-source ()
  (interactive)
  (emacs-wiki-publish-this-page)
  (find-file (emacs-wiki-published-file)))
(defun emacs-wiki-preview-html ()
  (interactive)
  (emacs-wiki-publish-this-page)
  (browse-url (emacs-wiki-published-file)))

(setq emacs-wiki-menu-factory 'emacs-wiki-menu-make-from-list)
;;_+ Automatically publish files upon saving
(defun sacha-emacs-wiki-auto-publish ()
  (when (derived-mode-p 'emacs-wiki-mode)
    (unless emacs-wiki-publishing-p
      (let ((emacs-wiki-publishing-p t)
	    (emacs-wiki-after-wiki-publish-hook nil))
	(emacs-wiki-publish-this-page)))))
(add-hook 'emacs-wiki-mode-hook
	  (lambda () (add-hook 'after-save-hook
			       'sacha-emacs-wiki-auto-publish
			       nil t)))
(setq emacs-wiki-charset-default "utf-8")

;; 自定义函数emacs-wiki-unline-toggle，用于自动对WikiName添加/删除<nop>标记
;;{{{ copy from yason@emacswiki, modified by Yu Li
(defun emacs-wiki-unlink-toggle ()
  "Toggle <nop> string in the beginning of the current word, to
un/make a word emacs-wiki link. The current word depends on the
point: if the cursor is on a non-whitespace character, it's
considered a word surrounded by whitespace. If the cursor is on a
whitespace character, the next word is looked up. This way
addressing a word works intuitively after having arrived on the
spot using forward-word."
  (interactive)
  (save-excursion
    (with-current-buffer (current-buffer)
    (if (looking-at "[ \t]")
        (goto-char (- (re-search-forward "[A-Za-z<>]") 1))
      (goto-char (+ (re-search-backward "[^A-za-z<>]") 1)))
    (if (looking-at "<nop>")
        (delete-char 5)
      (insert "<nop>")))))
;;}}}

;;---------------programming------------------------
(add-to-list 'load-path "~/.emacs.d/lisp")

;; csharp mode
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;; python mode
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
	      interpreter-mode-alist)) 
(autoload 'python-mode "python-mode" "Python editing mode." t)

; add my customization
;;(add-hook 'python-mode-hook 'my-python-hook)
; this gets called by outline to deteremine the level. Just use the length of the whitespace
(defun py-outline-level ()
  (let (buffer-invisibility-spec)
    (save-excursion
      (skip-chars-forward "\t ")
      (current-column))))
; this get called after python mode is enabled
(defun my-python-hook ()
  ; outline uses this regexp to find headers. I match lines with no indent and indented "class"
  ; and "def" lines.
  ;(setq outline-regexp "[^ \t]\\|[ \t]*\\(def\\|class\\) ")
  (setq outline-regexp "[^ \t\n]\\|[ \t]*\\(def\\|class\\) ")
  ; enable our level computation
  (setq outline-level 'py-outline-level)
  ; do not use their \C-c@ prefix, too hard to type. Note this overides some python mode bindings
  (setq outline-minor-mode-prefix "\C-c")
  ; turn on outline mode
  (outline-minor-mode t)
  ; initially hide all but the headers
  (hide-body)
  ; I use CUA mode on the PC so I rebind these to make the more accessible
  (local-set-key [?\C-\t] 'py-shift-region-right)
  (local-set-key [?\C-\S-\t] 'py-shift-region-left)
  ; make paren matches visible
  (show-paren-mode 1)
) 

;C-c C-q folding all
;C-c C-a show all
;C-c C-c folding current
;C-c C-e show current

;; add these lines if you like color-based syntax highlighting
;(global-font-lock-mode t)
;(setq font-lock-maximum-decoration t) 
;(set-language-environment 'Chinese-GB)
;(set-keyboard-coding-system 'euc-cn)
(set-clipboard-coding-system 'euc-cn)
;(set-terminal-coding-system 'euc-cn)
;(set-buffer-file-coding-system 'euc-cn)
;(set-selection-coding-system 'euc-cn)
;(modify-coding-system-alist 'process "*" 'euc-cn)
;(setq default-process-coding-system
;      '(euc-cn . euc-cn))
;(setq-default pathname-coding-system 'euc-cn) 

;;c/c++

(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'c-mode-hook 'linux-c-mode)
(add-hook 'c++-mode-hook 'linux-cpp-mode)
(setq imenu-sort-function 'imenu--sort-by-name)
(defun linux-c-mode()
  (define-key c-mode-map [return] 'newline-and-indent)
  (interactive)
  (c-set-style "K&R")
  (c-toggle-auto-state)
  (c-toggle-hungry-state)
  (setq c-basic-offset 4)
  (imenu-add-menubar-index)
  (which-function-mode))
(defun linux-cpp-mode()
  (define-key c++-mode-map [return] 'newline-and-indent)
  (define-key c++-mode-map [(control c) (c)] 'compile)
  (interactive)
  (c-set-style "k&r")
  (c-toggle-auto-state)
  (c-toggle-hungry-state)
  (setq c-basic-offset 4)
  (imenu-add-menubar-index)
  (which-function-mode)
  )

(put 'upcase-region 'disabled nil)

(defun my-c-mode-common-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  (setq c-macro-shrink-window-flag t)
  (setq c-macro-preprocessor "cpp")
  (setq c-macro-cppflags " ")
  (setq c-macro-prompt-flag t)
  ;(setq hs-minor-mode t)
  (setq abbrev-mode t)
  ;;; hungry-delete and auto-newline
  (c-toggle-auto-hungry-state 1)
  (c-set-style "k&r")
  (which-function-mode)
  ;;按键定义
  (define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
  (define-key c-mode-base-map [(return)] 'newline-and-indent)
  (define-key c-mode-base-map [(f9)] 'compile)
  (define-key c-mode-base-map [(meta \`)] 'c-indent-command)
  (define-key c-mode-base-map [(tab)] 'hippie-expand)
  ;(define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
  ;(define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu)  
)

(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/common")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/contrib")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/ede")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/semantic")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/srecode")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/cogre")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/eieio")

(require 'cedet)
;(require 'semantic/ia)
;(require 'semantic-tag-folding nil 'noerror)
 
;; Enable EDE (Project Management) features
(global-ede-mode t)

 
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)
(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(semantic-load-enable-gaudy-code-helpers)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TAGS Menu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))

(add-hook 'semantic-init-hooks 'my-semantic-hook)

;;;;;;;;;;;;;;;;;;;;;;
;;;; Semantic DataBase
;;;;;;;;;;;;;;;;;;;;;;
(setq semanticdb-default-save-directory
      (expand-file-name "~/.emacs.d/semanticdb"))
 
;; Enable SRecode (Template management) minor-mode.
(global-srecode-minor-mode 1)
(global-semantic-tag-folding-mode 1)

;; fold and unfold block
(define-key semantic-tag-folding-mode-map (kbd "C-c , -") 'semantic-tag-folding-fold-block)
(define-key semantic-tag-folding-mode-map (kbd "C-c , =") 'semantic-tag-folding-show-block)
;; fold and unfold block
(define-key semantic-tag-folding-mode-map (kbd "C-_") 'semantic-tag-folding-fold-all)
(define-key semantic-tag-folding-mode-map (kbd "C-+") 'semantic-tag-folding-show-all)

(semantic-add-system-include "~/bin/MinGW/include" 'c++-mode)
;(setq memcached-project
;      (ede-cpp-root-project "memcached"
;                            :file "~/GitHub/memcached-1.4.5/Makefile.in"
;                            :system-include-path '("~/C/include"
;                                                   "~/bin/MinGW/include")
;			    )
;)

;include file
(defconst cedet-user-include-dirs
  (list "." 
	"../include" ))
(defconst cedet-win32-include-dirs
  (list "~/bin/MinGW/include"
        "~/bin/MinGW/include/c++/3.4.5"
        "~/bin/MinGW/include/c++/3.4.5/mingw32"
        "~/bin/MinGW/include/c++/3.4.5/backward"
        "~/bin/MinGW/lib/gcc/mingw32/3.4.5/include"
        "C:\\Program Files\\Microsoft Visual Studio 10.0\\VC\\include"))

(require 'semantic-c nil 'noerror)
(let ((include-dirs cedet-user-include-dirs))
  (when (eq system-type 'windows-nt)
    (setq include-dirs (append include-dirs cedet-win32-include-dirs)))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

;; goto function define
(global-set-key [f12] 'semantic-ia-fast-jump)
;; back to function call
(global-set-key [S-f12]
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))

(define-key c-mode-base-map [M-f1] 'semantic-analyze-proto-impl-toggle)  

;;EDE
(require 'ede nil 'noerror)
(global-ede-mode t)

;; switch between header and source
(defun dts-switch-between-header-and-source ()
  "Switch between a c/c++ header (.h) and its corresponding source (.c/.cpp)."
  (interactive)
  (setq bse (file-name-sans-extension buffer-file-name))
  (setq ext (downcase (file-name-extension buffer-file-name)))
  (cond
   ((or (equal ext "h") (equal ext "hpp"))
        ;; first, look for bse.c 
        (setq nfn (concat bse ".c"))
        (if (file-exists-p nfn)
                (find-file nfn)
          (progn
                (setq nfn (concat bse ".cpp"))
                (find-file nfn)
                )
          )
        )
   ;; second condition - the extension is "cpp"
   ((equal ext "cpp")
        (setq nfn (concat bse ".h"))
        (if (file-exists-p nfn)
                (find-file nfn)
          (progn
                (setq nfn (concat bse ".hpp"))
                (find-file nfn)
                )
          )
        )
   
   ( (equal ext "c")
         (setq nfn (concat bse ".h"))
         (find-file nfn)
         )
   
   ( (equal ext "hxx")
         (setq nfn (concat bse ".cxx"))
         (find-file nfn)
         )
   
   ( (equal ext "cxx")
         (setq nfn (concat bse ".hxx"))
         (find-file nfn)
         )
   
   ( (equal ext "hx")
         (setq nfn (concat bse ".cx"))
         (find-file nfn)
         )
   
   ( (equal ext "cx")
         (setq nfn (concat bse ".hx"))
         (find-file nfn)
         )
   
   );;endof:cond
  )

(require 'eassist nil 'noerror)
(define-key c-mode-base-map [f11] 'eassist-switch-h-cpp)
(define-key c-mode-base-map [C-f11] 'dts-switch-between-header-and-source)

(setq eassist-header-switches
      '(("h" . ("cpp" "cxx" "c++" "CC" "cc" "C" "c" "mm" "m"))
        ("hh" . ("cc" "CC" "cpp" "cxx" "c++" "C"))
        ("hpp" . ("cpp" "cxx" "c++" "cc" "CC" "C"))
        ("hxx" . ("cxx" "cpp" "c++" "cc" "CC" "C"))
        ("h++" . ("c++" "cpp" "cxx" "cc" "CC" "C"))
        ("H" . ("C" "CC" "cc" "cpp" "cxx" "c++" "mm" "m"))
        ("HH" . ("CC" "cc" "C" "cpp" "cxx" "c++"))
        ("cpp" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
        ("cxx" . ("hxx" "hpp" "h++" "HH" "hh" "H" "h"))
        ("c++" . ("h++" "hpp" "hxx" "HH" "hh" "H" "h"))
        ("CC" . ("HH" "hh" "hpp" "hxx" "h++" "H" "h"))
        ("cc" . ("hh" "HH" "hpp" "hxx" "h++" "H" "h"))
        ("C" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
        ("c" . ("h"))
        ("m" . ("h"))
        ("mm" . ("h"))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; r language
(load "~/.emacs.d/lisp/ess-5.14/lisp/ess-site")
(require 'ess-site)
(setq inferior-R-program-name "~/bin/R/R-2.15.1/bin/x64/Rterm.exe")
;;设置set-buffer-process-coding-system，这样就能正确使用中文了.
;(add-hook 'ess-post-run-hook (function (lambda ()
;(set-buffer-process-coding-system 'cn-gb-2312 'cn-gb-2312))))
;(setq inferior-R-program-name "~/bin/R/R-2.14.0/bin/i386/Rgui.exe")
;(add-to-list auto-mode-alist ("\\.rd\\" . Rd-mode))
;设置set-buffer-process-coding-system，这样就能正确使用中文了.
;(setq load-path (cons  (expand-file-name "E:/Programs/emacs-21.3/ess-5.3.0/lisp/ess-site") load-path )
;(autoload 'R "ess-site" "" t)
;(add-hook 'ess-post-run-hook (function (lambda () (set-buffer-process-coding-system 'cn-gb-2312 'cn-gb-2312))))