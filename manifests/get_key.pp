define serverbackup_cdp_agent::get_key {
    $server_filename = regsubst($name, '^(.*:)//([a-z0-9\-.]+)(:[0-9]+)?(.*)$','\2')
    exec { "/usr/bin/r1soft-setup --get-key ${name}":
        creates     => "/usr/sbin/r1soft/conf/server.allow/${server_filename}",
        require     => [
            Package['r1soft-cdp-enterprise-agent'],
            Exec['get-module'],
        ],
        logoutput   => true,
        notify      => Service['cdp-agent'],
    }
}

