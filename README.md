# nagios_plugins

Set of nagios plugins created for OpenStack

## check_rados_fs.sh

Check rados filesystem (swift.buckets) in order to calculate the percentage of 
used resources and compare with the warning and critical levels defined in the 
plugin call. Usage:

    $ check_rados_fs.sh -w <warnlevel> -c <critlevel>

Where warnlevel and critlevel is percentage value without % (could be integer 
of float). Example:


	$ /usr/lib64/nagios/plugins/check_rados_fs.sh -w 80 -c 90


## check_swift_health.sh

Check the Health status of the OpenStack Swift service through the call to the 
http://<swift server>:8080/healthcheck and return the status OK or CRITICAL 
depending of the value returned. It needs a parameter which is the IP address 
of the OpenStack Swift server. The script check that the IP introduced is a 
correct IPv4 address. Usage:

    $ check_swift_health.sh -H <IP> 

Where IP is the OpenStack Swift IP address. Example:

    	$ /usr/lib64/nagios/plugins/check_swift_health.sh -H 127.0.0.1

## check_mem.sh

Check the memory load of the machine through the call to free tool and compare 
with the warning and critical levels defined in the plugin call. Usage:

    $ check_mem.sh -w <warnlevel> -c <critlevel>

Where warnlevel and critlevel is percentage value without % (could be integer 
of float). Example:


	$ /usr/lib64/nagios/plugins/check_rados_fs.sh -w 80 -c 90

## check_ceilometer

Check that the different ceilometer processes are up and running. The list of 
processes to be checked remotelly are:

* ceilometer-agent-central
* ceilometer-agent-notification
* ceilometer-alarm-evaluator
* ceilometer-alarm-notifier
* ceilometer-api
* ceilometer-collector

Additionally, it checks the port 8777 in order to know if the ceilometer api is
working properly. Usage:

    $ /usr/lib64/nagios/plugins/check_ceilometer

## check_rabbitmq.sh

Check that the RabbitMQ process is working properly. The list of processes to be checked
remotelly are:

* inet_proc, 2 instances.
* beam_proc, 1 instance.
* rabbitmq_proc, 1 instance.
* epmd, 1 instance.

Additionally, it checks the TCP port 5672 in order to know if the rabbitmq api is
working properly. Usage:


## check_novncproxy

This check displays the status of the nova-novncproxy in the list of provided hosts. 
If only one IP address is especified check that the service is up there, if there is 
more than one return OK if all of them are running CRITICAL if there is at least one 
of them down and ERROR if all of them are down. Usage:

    $ check_novncproxy [-h][-v][-V] -H 'a1.b1.c1.d1 a2.b2.c2.d2 ...'
        
Options:
-h, --help          show this help message and exit.
-V, --version       show version information and exit.
-v, --verbose       show verbose messages.
-H, --hosts list    check the list of hosts.
