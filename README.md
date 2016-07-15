# nagios_plugins
Set of nagios plugins created for OpenStack

## check_rados_fs.sh

Check rados filesystem (swift.buckets) in order to calculate the percentage of used resources and compare with the warning and critical levels defined in the plugin call. Usage:

    $ check_rados_fs.sh -w <warnlevel> -c <critlevel>

Where warnlevel and critlevel is percentage value without % (could be integer of float). Example:


	$ /usr/lib64/nagios/plugins/check_rados_fs.sh -w 80 -c 90


## check_swift_health.sh

Check the Health status of the OpenStack Swift service through the call to the http://<swift server>:8080/healthcheck and return the status OK or CRITICAL depending of the value returned. It needs a parameter which is the IP address of the OpenStack Swift server. The script check that the IP introduced is a correct IPv4 address. Usage:

    $ check_swift_health.sh -H <IP> 

Where IP is the OpenStack Swift IP address. Example:

    	$ /usr/lib64/nagios/plugins/check_swift_health.sh -H 127.0.0.1
