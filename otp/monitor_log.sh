#!/bin/bash
while inotifywait -e modify /var/log/supervisor/vta_otp.log; do
    if (tail -n1 /var/log/supervisor/vta_otp.log | grep java.lang.OutOfMemoryError;) ||
       (tail -n1 /var/log/supervisor/vta_otp.log | grep org.opentripplanner.routing.error.GraphNotFoundException;)
    then
        /usr/local/bin/supervisorctl restart vta:vta_otp
    fi
done