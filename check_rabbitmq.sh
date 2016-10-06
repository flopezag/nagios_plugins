#!/bin/bash

function message {
        local inet_proc=$(grep -o "inet_gethost" $1 | wc -l)
        local beam_proc=$(grep -o "beam" $1 | wc -l)
        local rabbitmq_proc=$(grep -o "rabbitmq-server" $1 | wc -l)
        local epmd=$(grep -o "epmd" $1 | wc -l)

        if [ "$inet_proc" -ne "2" ]; then
                missing_process="inet_gethost($inet_proc/2)"
        fi

        if [ "$beam_proc" -ne "1" ]; then
                missing_process=$missing_process", beam($beam_proc/1)"
        fi

        if [ "$rabbitmq_proc" -ne "1" ]; then
                missing_process=$missing_process", rabbitmq-server($rabbitmq_proc/1)"
        fi

        if [ "$epmd" -ne "1" ]; then
                missing_process=$missing_process", epmd($epmd/1)"
        fi

        echo $missing_process
}

ps auxw | grep ^rabbit > .out
numberproc=$(ps auxw | grep ^rabbit | wc -l)

if [ "$numberproc" = "5" ]; then
        # All the identified processes are running, therefore we check that
        # TCP port is running properly.
        check_tcp=$(./check_tcp -p 5672)
        rm .out

        echo "RabbitMQ $check_tcp"
        exit 0
else
        # Some of the proccesses are missing, get information about them.

        # Sintax of Script's Output
        # [STATUS]- [INFORMATION TO BE DISPLAYED ON NAGIOS SERVER CONSOLE] | [INFORMATION TO BE DISPLAYED GRAPHICALLY]
        nameprocess=$(message .out)
        rm .out

        echo "RabbitMQ CRITICAL- Missing RabbitMQ process: $nameprocess|MISSINGPROCESS=$nameprocess"
        exit 2
fi
