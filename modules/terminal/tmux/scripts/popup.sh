#!/usr/bin/env bash
# Attach to the "popup" session from inside display-popup.
#
# A popup's pty has no pixel size, so the nested tmux client queries it (\e[14t).
# Popups never answer, and while that query is pending tmux holds a lone Escape
# for 500ms and merges it with the next key into M-<key>. Giving the pty a pixel
# size up front means the query is never sent.
@python3@ -c '
import fcntl, struct, termios
r, c, _, _ = struct.unpack("HHHH", fcntl.ioctl(0, termios.TIOCGWINSZ, bytes(8)))
fcntl.ioctl(0, termios.TIOCSWINSZ, struct.pack("HHHH", r, c, c * 8, r * 16))
'
exec tmux new-session -A -s popup
