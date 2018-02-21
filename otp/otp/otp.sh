#!/bin/sh
# Run OTP in standalone mode
# Standalone OTP can build a graph, visualize a graph, run an OTP API server,
# or any combination of these.
java -Xmx6G -Xverify:none -jar /srv/tripplanner/otp/otp-1.2.0-shaded.jar --build /srv/tripplanner/data/ --cache /srv/tripplanner/otp/ned --inMemory --server --port 8888 > /var/log/otp.log &
