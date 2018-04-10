# xbacklight - Adjust your screen brightness with the external `xbacklight' tool.

Bind `xbacklight-increase` and `xbacklight-decrease` to some
keys and adjust `xbacklight-step` if you want the brightness to
increase/decrease in different steps then 10%.

With `use-package` the config could look like:

``` emacs-lisp
(use-package xbacklight
  :bind (("<XF86MonBrightnessUp>" . xbacklight-increase)
         ("<XF86MonBrightnessDown>" . xbacklight-decrease)))
```
