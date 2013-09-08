#!/bin/bash

# As my mail notification system, this displays 3 unread mail counts if any is greater than zero. The unread mail
# counts are outputted by scripts ~/bin/mailX.py, each of which monitor a different account.

mail1=$(mail1.py)
mail2=$(mail2.py)
mail3=$(mail3.py)

if [ $mail1 -gt 0 ] || [ $mail2 -gt 0 ] || [ $mail3 -gt 0 ]; then
    echo " ⮣ $mail1$mail2$mail3 "
fi
