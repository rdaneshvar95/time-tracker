total=0
while read -r line; do
    if [[ $line == START* ]]
    then
        date=$(echo $line | cut -c 8-)
        start=$(date -j -f "%a %b %e %H:%M:%S %Z %Y" "$date" +%s)
    elif [[ $line == STOP* ]]
    then
        date=$(echo $line | cut -c 7-)
        stop=$(date -j -f "%a %b %e %H:%M:%S %Z %Y" "$date" +%s)
    else
        diff=$((stop-start))
        total=$((total+diff))
        seconds=$((diff%60))
        minutes=$((diff%3600/60))
        hours=$((diff/3600))
        echo $(printf "%d:%02d:%02d" $hours $minutes $seconds)
    fi
done < logbook.txt
echo "\n* TOTAL *"
seconds=$((total%60))
minutes=$((total%3600/60))
hours=$((total/3600))
echo $(printf "%02d:%02d:%02d" $hours $minutes $seconds)
