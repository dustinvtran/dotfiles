#!/usr/bin/env python
"""Print to stdout the email address and its unread mail count if greater than
zero."""

import imaplib

emails = ["dustinviettran@gmail.com", "dtran@g.harvard.edu"]
passwords  = ["", ""] # censored
unread = [None]*2

for i in range(2):
    server = imaplib.IMAP4_SSL("imap.gmail.com", "993")
    server.login(emails[i], passwords[i])
    server.select()
    unread[i] = len(server.search(None, "UnSeen")[1][0].split())
    server.logout()

if unread[0] > 0 and unread[1] > 0:
    print("⮣ %s: %i, %s: %i" % (emails[0], unread[0], emails[1], unread[1]))
elif unread[0] > 0:
    print("⮣ %s: %i" % (emails[0], unread[0]))
elif unread[1] > 0:
    print("⮣ %s: %i" % (emails[1], unread[1]))
else:
    print("")
