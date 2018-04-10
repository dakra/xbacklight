;;; xbacklight.el --- Adjust screen brightness with xbacklight   -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Daniel Kraus

;; Author: Daniel Kraus <daniel@kraus.my>
;; Version: 0.1
;; Package-Requires: ((emacs "24.4"))
;; Keywords: multimedia
;; URL: https://github.com/dakra/xbacklight

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Adjust your screen brightness with the external `xbacklight' tool.

;; Bind `xbacklight-increase' and `xbacklight-decrease' to some
;; keys and adjust `xbacklight-step' if you want the brightness to
;; increase/decrease in different steps then 10%.

;; With `use-package' the config could look like:

;; (use-package xbacklight
;;   :bind (("<XF86MonBrightnessUp>" . xbacklight-increase)
;;          ("<XF86MonBrightnessDown>" . xbacklight-decrease)))

;;; Code:

(defgroup xbacklight nil
  "Adjust screen brightness with `xbacklight'"
  :prefix "xbacklight-"
  :group 'external)

(defcustom xbacklight-path (executable-find "xbacklight")
  "Path to `xbacklight' executable."
  :type 'string
  :group 'xbacklight)

(defcustom xbacklight-step 10
  "In what step amounts in % should the brightness get de-/increased."
  :type 'integer
  :group 'xbacklight)

(defcustom xbacklight-steps 20
  "Number of steps to take while fading."
  :type 'integer
  :group 'xbacklight)

(defcustom xbacklight-time 200
  "Length of time to spend fading the backlight between old and new value."
  :type 'integer
  :group 'xbacklight)

(defun xbacklight-get ()
  "Get screen brightness."
  (interactive)
  (string-to-number
   (shell-command-to-string (format "%s -get" xbacklight-path))))

;;;###autoload
(defun xbacklight-increase (&optional step)
  "Increase the brightness by STEP."
  (interactive "P")
  (start-process "xbacklight" nil xbacklight-path
                 "-inc"   (number-to-string (or step xbacklight-step))
                 "-time"  (number-to-string xbacklight-time)
                 "-steps" (number-to-string xbacklight-steps))
  (message "Screen brightness: %d%%" (xbacklight-get)))

;;;###autoload
(defun xbacklight-decrease (&optional step)
  "Decrease the brightness by STEP."
  (interactive "P")
  (start-process "xbacklight" nil xbacklight-path
                 "-dec"   (number-to-string (or step xbacklight-step))
                 "-time"  (number-to-string xbacklight-time)
                 "-steps" (number-to-string xbacklight-steps))
  (message "Screen brightness: %d%%" (xbacklight-get)))

(provide 'xbacklight)
;;; xbacklight.el ends here
