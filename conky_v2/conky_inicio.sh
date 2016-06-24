#! /bin/bash sleep 5
conky -q -c ~/.conky/.conkyrc_bar &
conky -c ~/.conky/.conkyrc_mpd &
conky -c ~/.conky/.conkyrc_rss &
conky -c ~/.conky/.conkyrc_clima & exit
