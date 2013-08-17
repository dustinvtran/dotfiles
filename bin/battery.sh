#! /bin/bash

# This displays a bitmap icon, battery status, and battery percent depending on how high/low the percent.

batperc=$(acpi -b | sed -n "1p" | awk -F " " '{print $4}' | head -c3)
batpercint=$(acpi -b | sed -n "1p" | awk -F "[% ]" '{print $4}' | head -c3)
batstatus=$(acpi -b | sed -n "1p" | awk -F "[, ]" '{print $3}')

if [ "$batstatus" == "Charging" ]; then
    echo "⮒ | $batstatus | $batperc "
elif [ $batpercint -lt 20 ]; then
    echo "⮐ $batstatus $batperc "
elif [ $batpercint -lt 50 ]; then
    echo "⮑ | $batstatus | $batperc "
# The next elif is a workaround for when acpi outputs 'Unknown, XX%' when it really means charged full at 100%.
# This is likely due to some hardware problem (laptop, surge protector, or otherwise). Too lazy to fix.
#elif [ "$batstatus" == "Unknown" ] && [ $batpercint -lt 100 ] && [ $batpercint -gt 90 ]; then
elif [ "$batstatus" == "Unknown" ]; then
    echo "⮎ 100% "
elif [ $batstatus == "Discharging" ]; then
    echo "⮏ | $batstatus | $batpercint% "
else
    echo "⮎ $batperc% "
fi
