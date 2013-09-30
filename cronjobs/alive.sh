!/bin/bash
# Cron Script to be launched every hour

me=`basename $0`
if [ $# -lt 4 ]; then
    echo "Allows the execution of a certain 'command' when there are a certain amount of 'message' entries in a 'logfile'."
    echo "The command checks the amount of entries in the last hour"
    echo "A tuned date format can be provided -- 'tsfmt'. By default 'YYYY-MM-DD HH' is used."
    echo "Usage: $me logfile message limit command [tsfmt]"
    exit 1
fi

# Input parameters
file=$1
message=$2
limit=$3
command=$4

if [ $# -eq 5 ]; then
    tsfmt=$5
else
    tsfmt="%Y-%m-%d %H"
fi

hour=$(date --date="-5 minutes" +"$tsfmt")
lines=$(grep "$hour" $file | grep "$message" | wc -l)
if [ $lines -ge $limit ]; then
    eval $command
fi